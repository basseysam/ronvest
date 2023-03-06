import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/fonts.dart';
import '../../styles/app_colors.dart';
import '../../styles/fonts.dart';

class BusyButton extends StatelessWidget {
  const BusyButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.disabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.borderRadius,
    this.fontSize,
    this.textColor,
    this.icon,
    this.backgroundColor = AppColors.white,
  }) : super(key: key);
  final String title;
  final VoidCallback onPress;
  final double? width;
  final double? height;
  final String? icon;
  final bool disabled;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final Color backgroundColor;
  final Color? textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onPress,
      child: Container(
        height: height ?? 64,
        width: width ?? double.infinity,
        decoration: BoxDecoration(

          color: disabled ? const Color(0xffF0F3F6) : backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(20),
        ),
        child: isLoading == true ? const CupertinoActivityIndicator(color: Colors.white,) :  Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextSemiBold(
                  title,
                  fontSize: fontSize,
                  style:  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: disabled ? const Color(0xff9EA9C1) : Colors.white ,
                    fontFamily: AppFonts.nunitoSansRegular
                  ),
                  color:
                      disabled ? AppColors.white.withOpacity(0.4) : AppColors.black,
                ),
              ),
              //Image.asset(icon!),
            ],
          ),
        ),
      ),
    );
  }
}
