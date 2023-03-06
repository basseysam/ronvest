import 'package:flutter/material.dart';

import '../../app/styles/app_colors.dart';

class CustomFormValidation {
  static Color getColor(String? text,
      FocusNode focus,
      String? validationError,) {
    if (focus.hasFocus && text == null) {
      return AppColors.red;
    } else if (focus.hasFocus &&
        text!.isEmpty &&
        validationError != null &&
        validationError.isNotEmpty) {
      return AppColors.red;
    } else if (focus.hasFocus &&
        text!.isNotEmpty &&
        validationError != null &&
        validationError.isEmpty) {
      return AppColors.primaryColor.withOpacity(0.28);
    } else if (text != null &&
        text.isNotEmpty &&
        validationError != null &&
        validationError.isEmpty) {
      return AppColors.primaryColor.withOpacity(0.28);
    } else if (validationError != null && validationError.isNotEmpty) {
      return AppColors.red;
    } else {
      return const Color(0xff00000000);
    }
  }


  static String errorMessage(String? text,
      String message,) {
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else {
      return '';
    }
  }

  static bool validateStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static String errorMessagePassword(String? text,
      String message,) {
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (text.length < 7) {
      return 'Password must be greater than 7 digits';
    } else {
      return '';
    }
  }

  static String errorMessageFirst(String? text,
      String message,) {
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (text.length <= 1) {
      return 'Invalid name';
    } else {
      return '';
    }
  }

  static String errorMessageUsername(String? text,
      String message,) {
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (text.length <= 5) {
      return 'Invalid username';
    } else {
      return '';
    }
  }


  static String errorAddress(String? text,
      String message,) {
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (text.length <= 1) {
      return 'Invalid address';
    } else {
      return '';
    }
  }


  static bool validateEmail(String value) {
    //String  pattern = r'^(?=.*?[@+\.])';
    //String  pattern = r'^(?=.*?[a-z0-9])';
    RegExp regExp = RegExp('[a-z0-9]+@[a-z]+.[a-z]');
    return regExp.hasMatch(value);
  }

  static String errorMessageEmail(String? text,
      String message,) {
    if (text == null) {
      return '';
    } else if (text.isEmpty) {
      return message;
    } else if (!validateEmail(text)) {
      return 'Invalid email';
    } else {
      return '';
    }
  }



}

