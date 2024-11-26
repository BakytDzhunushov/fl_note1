import 'package:fl_note1/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fl_note1/features/home/presentation/pages/home_page.dart';
import 'package:fl_note1/features/user_profile/widgets/custom_menu_button.dart';
import 'package:fl_note1/features/user_profile/widgets/custom_menu_button2.dart';
import 'package:fl_note1/features/user_profile/widgets/custom_user_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/image.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        height: size.height * 0.8,
                        width: size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImageConstant.backgroundImage),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const CustomUserImageProfile(),
                    Positioned(
                      top: 270,
                      child: state.user?.displayName == ""
                          ? Text(
                              state.user?.displayName ?? "",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          : const Text(
                              "User",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                    ),
                    Positioned(
                      top: 300,
                      child: Text(
                        state.user?.email ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomMenuButton(
                          title: 'Мой аккаунт',
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          ),
                        ),
                        CustomMenuButton2(size: size),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

