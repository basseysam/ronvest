import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ronvest/app/app.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../app/styles/app_colors.dart';
import '../../../../app/views/widgets/busy_button_two.dart';
import '../../../../app/views/widgets/touchables/touchable_opacity.dart';
import '../../../../core/constants/fonts.dart';
import '../../../../core/navigators/route_names.dart';
import '../../data/model/onboarding_items.dart';
import '../widgets/onboarding_widget.dart';

class ChooseAccount extends StatefulWidget {
  const ChooseAccount({Key? key}) : super(key: key);

  @override
  State<ChooseAccount> createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {

  late PageController _pageController;
  int _pageIndex = 0;

  List<OnboardingItems> items = [
    OnboardingItems(
        image: "assets/images/save_money.png",
        title: 'Save money the fun and easy way'),
    OnboardingItems(
        image: "assets/images/start_journey.png",
        title: 'Start a challenge or join other challenges and see yourself improve in your savings'),
    OnboardingItems(
        image: "assets/images/goals.png",
        title: "Discover multiple saving plans to help you reach your goals faster"),
    OnboardingItems(
        image: "assets/images/save_naira.png",
        title: "Save in Naira or Dollar and Swap currencies Instantly"),
    OnboardingItems(
        image: "assets/images/grow_tree.png",
        title: "Grow your savings with the best interest rates of up to 17.5% per annum"),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset('assets/images/logo_two.png', width: 125,),
              const Gap(80),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  controller: _pageController,
                  itemBuilder: (context, index) => OnBoardingWidget(
                      title: items[index].title,
                      image: items[index].image,),
                  itemCount: items.length,
                ),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 20,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmoothPageIndicator(
                              controller: _pageController, count: 5,
                              effect: const WormEffect(
                                  activeDotColor: AppColors.primaryColor,
                                  dotColor: AppColors.iconGray,
                                  dotHeight: 4,
                                  //expansionFactor: 2,
                                  dotWidth: 30
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const Gap(50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                        child: BusyButton(
                           backgroundColor: AppColors.primaryColor,
                          height: 55,
                          borderRadius: BorderRadius.circular(10),
                          title: 'Login', onPress: (){
                          Navigator.pushNamed(context, Routes.signInScreen);
                        },),
                    ),
                    const Gap(30),
                    Expanded(
                        child: BusyButton2(
                          height: 55,
                          borderRadius: BorderRadius.circular(10),
                          title: 'Sign up', onPress: (){
                            Navigator.pushNamed(context, Routes.signUpScreen);
                        },),
                    ),
                  ],
                ),
              ),
              const Gap(50),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Select language ',
                    style: const TextStyle(
                        color: AppColors.iconGray,
                        fontSize: 14,
                        fontFamily: AppFonts.nunitoSansRegular,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'English ',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                            fontFamily: AppFonts.nunitoSansRegular,
                            fontWeight: FontWeight.w400,),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigator.pushNamed(context, Routes.welcomeScreen);
                              // navigate to desired screen
                            }),
                      TextSpan(
                          text: 'Hausa Yoruba Igbo more ',
                          style: const TextStyle(
                            color: AppColors.iconGray,
                            fontSize: 14,
                            fontFamily: AppFonts.nunitoSansRegular,
                            fontWeight: FontWeight.w400,),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigator.pushNamed(context, Routes.welcomeScreen);
                              // navigate to desired screen
                            }),
                    ]),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),

    );
  }
}
