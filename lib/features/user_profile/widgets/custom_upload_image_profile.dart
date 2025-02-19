import 'dart:io';

import 'package:fl_note1/features/user_profile/cubit/upload_user_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

Future<void> customUploadImageProfile(BuildContext context) async {
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    final imageFile = File(pickedImage.path);
    final cubit = context.read<UploadUserImageCubit>();

    try {
      await cubit.updateProfilePicture(imageFile);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile picture updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  } else {
    return null;
  }
}