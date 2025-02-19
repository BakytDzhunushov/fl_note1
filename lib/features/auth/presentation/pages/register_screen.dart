import 'package:fl_note1/constant/image.dart';
import 'package:fl_note1/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fl_note1/features/auth/presentation/pages/login_screen.dart';
import 'package:fl_note1/features/auth/presentation/widgets/custom_pass_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool hintText = true;
  bool hintText2 = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Регистрация'),
        backgroundColor: Colors.blue[600],
        toolbarOpacity: 0.5,
        bottomOpacity: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstant.backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AuthSuccess) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              } else if (state is AuthFailure) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Ошибка"),
                      content: Text(state.errorMessage),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Повторите"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            builder: (context, state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _fromKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                                image: AssetImage(ImageConstant.logoImage),
                                // NetworkImage(
                                //     'https://static.vecteezy.com/system/resources/thumbnails/023/492/712/small_2x/3d-notes-icon-png.png'
                                //     ),
                                height: 150),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                hintText: 'Электронная почта',
                              ),
                              validator: _validateEmail,
                            ),
                            const SizedBox(height: 10),
                            CustomPasswordFormField(
                              hintText: 'Пароль',
                              obscureText: hintText,
                              keyboardType: TextInputType.text,
                              controller: _passwordController,
                              iconButton: IconButton(
                                onPressed: _onHintText,
                                icon: Icon(
                                  hintText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              validator: _validatePassword,
                            ),
                            const SizedBox(height: 10),
                            CustomPasswordFormField(
                              hintText: 'Подтвердите пароль',
                              obscureText: hintText,
                              keyboardType: TextInputType.text,
                              controller: _confirmPasswordController,
                              iconButton: IconButton(
                                onPressed: _onHintText2,
                                icon: Icon(
                                  hintText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              validator: _validatePassword,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onPressed: () {
                                  if (_fromKey.currentState!.validate()) {
                                    final email = _emailController.text.trim();
                                    final password =
                                        _passwordController.text.trim();

                                    context.read<AuthCubit>().register(
                                          email,
                                          password,
                                        );
                                  }
                                },
                                child: const Text(
                                  "Регистрация",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Divider(
                              height: 20,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Уже есть аккаунт?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  child: const Text(
                                    "Войти",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    // ToDo: Sign Up Navigation
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onHintText2() {
    setState(() {
      hintText2 = !hintText2;
    });
  }

  void _onHintText() {
    setState(() {
      hintText = !hintText;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Пожалуйста введите вашу почту или пароль.";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Пожалуйста введите вашу почту или пароль.";
    } else if (value.length < 6) {
      return "Пароль должен быть не менее 6 символов.";
    } else if (value != _passwordController.text.trim()) {
      return "Пароль не совпадает";
    }
    return null;
  }
}