import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ronvest/app/app.dart';
import 'package:ronvest/core/constants/constants.dart';
import 'package:ronvest/core/core.dart';
import 'package:ronvest/features/dashboard/presentation/pages/call_screen.dart';

import '../../../../app/styles/app_colors.dart';
import '../../data/dash_option.dart';
import '../../data/model.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final List<DashBoardCard> _cards = [
    DashBoardCard(
        title: 'Total Naira\nBalance',
        amount: '450,093.00',
        currency: '₦',
        balance: '45,093.00.',
        growth: '55%',
        positive: true),
    DashBoardCard(
        title: 'Total Dollar\nBalance',
        amount: '40,093.00',
        currency: '\$',
        balance: '55,093.00.',
        growth: '35%',
        positive: false),
  ];

  final List<DashOption> _options = [
    DashOption(title: 'Top up', icon: 'assets/icons/top_up.svg'),
    DashOption(title: 'Plans', icon: 'assets/icons/plans.svg'),
    DashOption(title: 'Challenge', icon: 'assets/icons/challenge.svg'),
    DashOption(title: 'Wallet', icon: 'assets/icons/wallet.svg'),
    DashOption(title: 'Portfolio', icon: 'assets/icons/portfolio.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD8E9F1),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CallScreen()));
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.video_call_outlined),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.46,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter,
                    colors: [
                  Color(0xff253E4A),
                  Color(0xff070C0F),
                ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TouchableOpacity(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.userProfile);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/ronvest.svg',
                          height: 35,
                          width: 35,
                        ),
                      ),
                      Image.asset(
                        'assets/images/logo_two.png',
                        width: 110,
                      ),
                      Stack(
                        children: [
                          const Icon(
                            Icons.notifications_none_outlined,
                            color: AppColors.primaryColor,
                            size: 32,
                          ),
                          Positioned(
                              child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  '4',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 10,
                                      fontFamily: AppFonts.nunitoSansLight),
                                ),
                              ),
                            ),
                          ))
                        ],
                      )
                    ],
                  ),
                )),
                const Gap(20),
                SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Wrap(
                    spacing: 20,
                    direction: Axis.horizontal,
                    children: List.generate(_cards.length, (index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 20, right: 70),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff7FCCEF).withOpacity(0.18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _cards[index].title,
                                  softWrap: true,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: AppFonts.nunitoSansRegular,
                                      color: AppColors.white),
                                ),
                                const Gap(50),
                                const Icon(
                                  Icons.visibility_off_outlined,
                                  color: AppColors.white,
                                )
                              ],
                            ),
                            const Gap(2),
                            Text(
                              '${_cards[index].currency} ${_cards[index].amount}',
                              softWrap: true,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: AppFonts.nunitoSansRegular,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Gap(2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _cards[index].positive == true
                                          ? '+'
                                          : '-',
                                      softWrap: true,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily:
                                              AppFonts.nunitoSansRegular,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      ' ${_cards[index].currency}',
                                      softWrap: true,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily:
                                              AppFonts.nunitoSansRegular,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                const Gap(50),
                                Row(
                                  children: [
                                    Text(
                                      ' ${_cards[index].growth}',
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily:
                                              AppFonts.nunitoSansRegular,
                                          color: _cards[index].positive == true
                                              ? AppColors.green
                                              : AppColors.red,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const Gap(2),
                            Text(
                              _cards[index].balance,
                              softWrap: true,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppFonts.nunitoSansRegular,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                const Gap(25),
                SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    spacing: 20,
                    direction: Axis.horizontal,
                    children: List.generate(_options.length, (index) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 1),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                  child: SvgPicture.asset(
                                _options[index].icon,
                                height: 30,
                                width: 30,
                              )),
                            ),
                          ),
                          const Gap(5),
                          Text(
                            _options[index].title.toUpperCase(),
                            style: const TextStyle(
                                color: AppColors.white,
                                fontFamily: AppFonts.nunitoSansRegular,
                                fontSize: 10,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Finish Setting up your Account',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.nunitoSansRegular,
                          color: AppColors.primaryColor,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500),
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '75%',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: AppColors.black,
                              fontSize: 18,
                              fontFamily: AppFonts.nunitoSansRegular),
                        ),
                        Text(
                          '7 out of 10\n completed',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: AppColors.black,
                              fontSize: 11,
                              fontFamily: AppFonts.nunitoSansRegular),
                        ),
                      ],
                    ),
                    const Gap(10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.7,
                        minHeight: 10,
                        color: AppColors.primaryColor,
                        backgroundColor: AppColors.iconGray.withOpacity(0.3),
                      ),
                    ),
                    const Gap(20),
                    Divider(
                      thickness: 0.5,
                      color: AppColors.textColor.withOpacity(0.2),
                    ),
                    const Gap(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                        ),
                        Gap(10),
                        Text(
                          'Personal Information',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: AppColors.primaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppFonts.nunitoSansRegular),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      children: const [
                        Gap(35),
                        Expanded(
                          child: Text(
                            'When you register for an account,we collect personal information',
                            softWrap: true,
                            style: TextStyle(
                                //  fontStyle: FontStyle.italic,
                                color: AppColors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFonts.nunitoSansRegular),
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Divider(
                      thickness: 0.5,
                      color: AppColors.textColor.withOpacity(0.2),
                    ),
                    const Gap(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.verified_user,
                          color: AppColors.primaryColor,
                        ),
                        Gap(10),
                        Text(
                          'Verification',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: AppColors.primaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppFonts.nunitoSansRegular),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Divider(
                      thickness: 0.5,
                      color: AppColors.textColor.withOpacity(0.2),
                    ),
                    const Gap(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.email,
                          color: AppColors.primaryColor,
                        ),
                        Gap(10),
                        Text(
                          'Confirm Mail',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: AppColors.primaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppFonts.nunitoSansRegular),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
