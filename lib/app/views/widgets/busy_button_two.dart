import 'package:flutter/material.dart';

import '../../../core/constants/fonts.dart';
import '../../styles/app_colors.dart';
import '../../styles/fonts.dart';

class BusyButton2 extends StatelessWidget {
  const BusyButton2({
    Key? key,
    required this.title,
    required this.onPress,
    this.disabled = false,
    this.width,
    this.height,
    this.borderRadius,
    this.fontSize,
    this.icon,
    this.backgroundColor = AppColors.primaryColor,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onPress,
      child: Container(
        height: height ?? 64,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff00000000),
          border: Border.all(color: AppColors.primaryColor, width: 1.5),
          //disabled ? backgroundColor.withOpacity(0.4) : backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(20),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextSemiBold(
                  title,
                  fontSize: fontSize,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.nunitoSansRegular
                  ),
                  color: AppColors.primaryColor
                  //disabled ? AppColors.white.withOpacity(0.4) : AppColors.white,
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
