import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_note1/constant/image.dart';
import 'package:fl_note1/features/auth/presentation/pages/login_screen.dart';
import 'package:fl_note1/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Image(
          image: AssetImage(
            ImageConstant.logoImage,
          ),
          height: 250,
        ),
      ),
    );
  }

  Future<void> navigateToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }
}