import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';

import '../../../../app/styles/app_colors.dart';
import '../../../../app/views/widgets/appbar.dart';
import '../../../../app/views/widgets/busy_button.dart';
import '../../../../app/views/widgets/input_field.dart';
import '../../../../app/views/widgets/touchables/touchable_opacity.dart';
import '../../../../core/constants/fonts.dart';
import '../../../../core/injections/injection_container.dart';
import '../../../../core/navigators/route_names.dart';
import '../../../../core/utils/custom_form_validation.dart';
import '../../../shared/helpers/popup.dart';
import '../../../shared/helpers/toast.dart';
import '../provider/auth_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _firstNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isLoading = false;
  bool _check = false;

  late StreamController<String> firstNameStreamController;
  late StreamController<String> emailStreamController;
  late StreamController<String> passwordStreamController;
  final ValueNotifier<bool> _canSubmit = ValueNotifier(false);

  @override
  void initState() {
    firstNameStreamController = StreamController<String>.broadcast();
    emailStreamController = StreamController<String>.broadcast();
    passwordStreamController = StreamController<String>.broadcast();

    _firstNameController.addListener(() {
      firstNameStreamController.sink.add(_firstNameController.text.trim());
      validateInputs();
    });


    _emailController.addListener(() {
      emailStreamController.sink.add(_emailController.text.trim());
      validateInputs();
    });

    _passwordController.addListener(() {
      passwordStreamController.sink.add(_passwordController.text.trim());
      validateInputs();
    });

    super.initState();
  }


  void validateInputs() {
    var canSumit = true;
    final firstNameError = CustomFormValidation.errorMessageFirst(
      _firstNameController.text.trim(),
      'Full name is required',
    );

    final emailError = CustomFormValidation.errorMessageUsername(
      _emailController.text.trim(),
      'Username is required',
    );

    final passwordError = CustomFormValidation.errorMessagePassword(
      _passwordController.text.trim(),
      'Password is required',
    );



    if (firstNameError != '' ||
        passwordError != '' ||
        emailError != '') {
      canSumit = false;
    }
    _canSubmit.value = canSumit;
  }

  @override
  Widget build(BuildContext context) {
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
          physics: const BouncingScrollPhysics(),
          padding:const EdgeInsets.symmetric(horizontal: 20) ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(MediaQuery.of(context).size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text('Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26,
                        fontStyle: FontStyle.italic,
                        color: AppColors.black,
                        fontFamily: AppFonts.nunitoSansRegular,
                        fontWeight: FontWeight.w500
                    ),),
                ],
              ),
              const Gap(30),
              StreamBuilder<String>(
                stream: emailStreamController.stream,
                builder: (context, snapshot) {
                  return InputField(
                    textInputType: TextInputType.emailAddress,
                    prefix: SvgPicture.asset("assets/icons/mail.svg"),
                    controller: _emailController,
                    placeholder: 'Username',
                    label: "",
                    fieldFocusNode: _emailFocus,
                    validationMessage:
                    CustomFormValidation.errorMessageUsername(
                      snapshot.data,
                      'Username is required ',
                    ),
                    validationColor: CustomFormValidation.getColor(
                      snapshot.data,
                      _emailFocus,
                      CustomFormValidation.errorMessageUsername(
                        snapshot.data,
                        'Username is required ',
                      ),
                    ),
                  );
                },
              ),
              const Gap(10),
              StreamBuilder<String>(
                stream: passwordStreamController.stream,
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        prefix: SvgPicture.asset("assets/icons/lock.svg"),
                        controller: _passwordController,
                        textInputType: TextInputType.visiblePassword,
                        placeholder: 'Password',
                        label: "Password",
                        password: true,
                        fieldFocusNode: _passwordFocus,
                        validationMessage:
                        CustomFormValidation.errorMessagePassword(
                          snapshot.data,
                          'Password is required',
                        ),
                        validationColor: CustomFormValidation.getColor(
                          snapshot.data,
                          _passwordFocus,
                          CustomFormValidation.errorMessagePassword(
                            snapshot.data,
                            'Password is required',
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Gap(23),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: const [
                      Text('Forgot Password?',
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: AppFonts.nunitoSansRegular,
                            color: AppColors.textColor,
                            height: 1,
                            fontWeight: FontWeight.w400
                        ),)
                    ],
                  ),
                ],
              ),
              const Gap(50),
              BusyButton(
                isLoading: _isLoading,
                  height: 50,
                  backgroundColor: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  title: 'Sign In my Account', onPress: () async {
                setState(() {
                  _isLoading = true;
                });

                final res = await sl<AuthProvider>().login(
                    context,
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim());

                Logger().d(res);

                if(res == true){
                  if(!mounted)return;
                  FocusScope.of(context).unfocus();
                  Navigator.pushNamed(context, Routes.dashboardScreen);
                  ToastMessage().displayPopup(
                      context: context,
                      text: 'Logged in successfully',
                      type: PopupType.success
                  );
                }else{
                  ToastMessage().displayPopup(
                      context: context, text: res.toString(), type: PopupType.failure);
                }

                setState(() {
                  _isLoading = false;
                });
               // Navigator.pushNamed(context, Routes.otpScreen);
              }),
              const Gap(23),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: 'Already have an account? - Sign Up  ',
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 12,
                        fontFamily: AppFonts.nunitoSansRegular,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[

                    ]),
              ),
              const Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
