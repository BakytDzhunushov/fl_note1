import 'package:fl_note1/constant/image.dart';
import 'package:fl_note1/features/user_profile/widgets/custom_confirm_dialog.dart';
import 'package:flutter/material.dart';

class CustomMenuButton2 extends StatelessWidget {
  const CustomMenuButton2({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => customConfirmDialog(context),
        child: Container(
          width: size.width,
          height: 50,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.9),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
            image: const DecorationImage(
              image: AssetImage(ImageConstant.backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: Text(
              "Выйти из аккаунта",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
