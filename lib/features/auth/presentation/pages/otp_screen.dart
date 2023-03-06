import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';

import '../../../../app/styles/app_colors.dart';
import '../../../../app/views/widgets/busy_button.dart';
import '../../../../app/views/widgets/appbar.dart';
import '../../../../app/views/widgets/input_field.dart';
import '../../../../app/views/widgets/touchables/touchable_opacity.dart';
import '../../../../core/constants/fonts.dart';
import '../../../../core/injections/injection_container.dart';
import '../../../../core/navigators/route_names.dart';
import '../../../../core/utils/custom_form_validation.dart';
import '../../../shared/helpers/popup.dart';
import '../../../shared/helpers/toast.dart';
import '../provider/auth_provider.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, required this.data}) : super(key: key);
  final Map<dynamic, dynamic> data;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  final pin1 = TextEditingController();
  final pin2 = TextEditingController();
  final pin3 = TextEditingController();
  final pin4 = TextEditingController();
bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Logger().d(widget.data);
    return  Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: TouchableOpacity(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: AppColors.primaryColor,)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(MediaQuery.of(context).size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Verification', style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppFonts.nunitoSansRegular,
                      color: AppColors.primaryColor
                  ),),
                ],
              ),
              const Gap(19),
              RichText(
                //textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Enter this OTP to verify your account ',
                    style: const TextStyle(
                        color: AppColors.iconGray,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontFamily: AppFonts.nunitoSansRegular,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                          text: '${widget.data['code']}',
                          style: const TextStyle(
                            color: AppColors.black,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontFamily: AppFonts.nunitoSansRegular,
                            fontWeight: FontWeight.w700,),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigator.pushNamed(context, Routes.welcomeScreen);
                              // navigate to desired screen
                            }),
                    ]),
              ),
              const Gap(10),
              const Gap(36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.09),
                          border: Border.all(width: 1, color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: pin1,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            onSaved: (pin1) {},
                            style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                                fontFamily: AppFonts.nunitoSansRegular,
                                fontWeight: FontWeight.w700),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: AppColors.black,
                            decoration:  const InputDecoration(
                              hintText: '',
                              hintStyle: TextStyle(
                                  fontFamily: AppFonts.nunitoSansRegular,
                                  color: Color(0xffD9D9D9),
                                  height: 2,
                                  fontSize: 25),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 10),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.09),
                          border: Border.all(width: 1, color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: pin2,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            onSaved: (pin1) {},
                            style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                                fontFamily: AppFonts.nunitoSansRegular,
                                fontWeight: FontWeight.w700),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: AppColors.black,
                            decoration:  const InputDecoration(
                              hintText: '',
                              hintStyle: TextStyle(
                                  fontFamily: AppFonts.nunitoSansRegular,
                                  color: Color(0xffD9D9D9),
                                  height: 2,
                                  fontSize: 25),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 10),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.09),
                          border: Border.all(width: 1, color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: pin3,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            onSaved: (pin1) {},
                            style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                                fontFamily: AppFonts.nunitoSansRegular,
                                fontWeight: FontWeight.w700),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: AppColors.black,
                            decoration:  const InputDecoration(
                              hintText: '',
                              hintStyle: TextStyle(
                                  fontFamily: AppFonts.nunitoSansRegular,
                                  color: Color(0xffD9D9D9),
                                  height: 2,
                                  fontSize: 25),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 10),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.09),
                          border: Border.all(width: 1, color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: pin4,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            onSaved: (pin1) {},
                            style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                                fontFamily: AppFonts.nunitoSansRegular,
                                fontWeight: FontWeight.w700),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: AppColors.black,
                            decoration:  const InputDecoration(
                              hintText: '',
                              hintStyle: TextStyle(
                                  fontFamily: AppFonts.nunitoSansRegular,
                                  color: Color(0xffD9D9D9),
                                  height: 2,
                                  fontSize: 25),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 10),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(36),
              BusyButton(
                backgroundColor: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
                  height: 50,
                  isLoading: _isLoading,
                  title: 'Verify', onPress: () async {
                  String otp = '${pin1.text}${pin2.text}${pin3.text}${pin4.text}';
                  Logger().d(otp);
                  setState(() {
                    _isLoading = true;
                  });

                  final res = await sl<AuthProvider>().verify(
                      context,
                      email: widget.data['email'],
                      email_code: otp
                  );

                  Logger().d(res);

                  if(res == true){
                    FocusScope.of(context).unfocus();
                    Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardScreen, (route) => false);

                    if(!mounted)return;
                    ToastMessage().displayPopup(
                        context: context,
                        text: 'User account verified successfully',
                        type: PopupType.success
                    );

                  }else{
                    ToastMessage().displayPopup(
                        context: context, text: res.toString(), type: PopupType.failure);
                  }

                  setState(() {
                    _isLoading = false;
                  });

                  //Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardScreen, (route) => false);
              }),
              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }
}
