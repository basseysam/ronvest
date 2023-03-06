import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../app/styles/app_colors.dart';
import '../../../../core/constants/fonts.dart';

class OnBoardingWidget extends StatelessWidget {
  final String image, title;

  const OnBoardingWidget(
      {Key? key, required this.image,  required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00000000),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Image.asset(image, height: 250, )),
                  const Gap(30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      title,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: AppFonts.nunitoSansRegular,
                          color: AppColors.primaryColor,
                          fontStyle: FontStyle.italic,
                          fontSize: 30,
                          height: 0.8,
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
