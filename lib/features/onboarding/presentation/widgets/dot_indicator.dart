import 'package:flutter/material.dart';

import '../../../../app/styles/app_colors.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({Key? key, this.isActive = false}) : super(key: key);
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: isActive ? 27 : 6,
      decoration: BoxDecoration(
          color: isActive ? AppColors.red : AppColors.primaryColor,),
    );
  }
}
