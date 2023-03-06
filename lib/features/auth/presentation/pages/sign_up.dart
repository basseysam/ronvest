import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';

import '../../../../app/styles/app_colors.dart';
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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _usernameNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isLoading = false;
  bool _check = false;

  late StreamController<String> firstNameStreamController;
  late StreamController<String> lastNameStreamController;
  late StreamController<String> usernameStreamController;
  late StreamController<String> emailStreamController;
  late StreamController<String> passwordStreamController;
  final ValueNotifier<bool> _canSubmit = ValueNotifier(false);

  @override
  void initState() {
    firstNameStreamController = StreamController<String>.broadcast();
    lastNameStreamController = StreamController<String>.broadcast();
    usernameStreamController = StreamController<String>.broadcast();
    emailStreamController = StreamController<String>.broadcast();
    passwordStreamController = StreamController<String>.broadcast();

    _firstNameController.addListener(() {
      firstNameStreamController.sink.add(_firstNameController.text.trim());
      validateInputs();
    });
    _lastNameController.addListener(() {
      lastNameStreamController.sink.add(_lastNameController.text.trim());
      validateInputs();
    });
    _usernameController.addListener(() {
      usernameStreamController.sink.add(_usernameController.text.trim());
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
      'First name is required',
    );

    final lastNameError = CustomFormValidation.errorMessageFirst(
      _lastNameController.text.trim(),
      'Last name is required',
    );

    final usernameError = CustomFormValidation.errorMessageUsername(
      _usernameController.text.trim(),
      'username is required',
    );

    final emailError = CustomFormValidation.errorMessageEmail(
      _emailController.text.trim(),
      'Email is required',
    );

    final passwordError = CustomFormValidation.errorMessagePassword(
      _passwordController.text.trim(),
      'Password is required',
    );



    if (firstNameError != '' ||
        passwordError != '' ||
        lastNameError != '' ||
        usernameError != '' ||
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
                  Text('Sign Up',
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
                stream: firstNameStreamController.stream,
                builder: (context, snapshot) {
                  return InputField(
                    prefix: SvgPicture.asset("assets/icons/user.svg"),
                    controller: _firstNameController,
                    placeholder: 'First name',
                    label: "First name",
                    fieldFocusNode: _firstNameFocus,
                    validationMessage:
                    CustomFormValidation.errorMessageFirst(
                      snapshot.data,
                      'First name is required',
                    ),
                    validationColor: CustomFormValidation.getColor(
                      snapshot.data,
                      _firstNameFocus,
                      CustomFormValidation.errorMessageFirst(
                        snapshot.data,
                        'First name is required ',
                      ),
                    ),
                  );
                },
              ),
              const Gap(10),
              StreamBuilder<String>(
                stream: lastNameStreamController.stream,
                builder: (context, snapshot) {
                  return InputField(
                    prefix: SvgPicture.asset("assets/icons/user.svg"),
                    controller: _lastNameController,
                    placeholder: 'Last name',
                    label: "Last name",
                    fieldFocusNode: _lastNameFocus,
                    validationMessage:
                    CustomFormValidation.errorMessageFirst(
                      snapshot.data,
                      'Last name is required',
                    ),
                    validationColor: CustomFormValidation.getColor(
                      snapshot.data,
                      _lastNameFocus,
                      CustomFormValidation.errorMessageFirst(
                        snapshot.data,
                        'Last name is required ',
                      ),
                    ),
                  );
                },
              ),
              const Gap(10),
              StreamBuilder<String>(
                stream: usernameStreamController.stream,
                builder: (context, snapshot) {
                  return InputField(
                    prefix: SvgPicture.asset("assets/icons/user.svg"),
                    controller: _usernameController,
                    placeholder: 'Username',
                    label: "username",
                    fieldFocusNode: _usernameNameFocus,
                    validationMessage:
                    CustomFormValidation.errorMessageUsername(
                      snapshot.data,
                      'Username is required',
                    ),
                    validationColor: CustomFormValidation.getColor(
                      snapshot.data,
                      _usernameNameFocus,
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
                stream: emailStreamController.stream,
                builder: (context, snapshot) {
                  return InputField(
                    textInputType: TextInputType.emailAddress,
                    prefix: SvgPicture.asset("assets/icons/mail.svg"),
                    controller: _emailController,
                    placeholder: 'Email Address',
                    label: "Email Address",
                    fieldFocusNode: _emailFocus,
                    validationMessage:
                    CustomFormValidation.errorMessageEmail(
                      snapshot.data,
                      'Email is required ',
                    ),
                    validationColor: CustomFormValidation.getColor(
                      snapshot.data,
                      _emailFocus,
                      CustomFormValidation.errorMessageEmail(
                        snapshot.data,
                        'Email is required ',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: _check,
                          onChanged: (value){
                            setState(() {
                              _check = value!;
                            });
                          }
                      ),
                      const Text('Be creating your account you\nhave to agree with our Teams and Conditions.',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 12,
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
                backgroundColor: AppColors.black,
                borderRadius: BorderRadius.circular(10),
                  title: 'Sign up my Account', onPress: () async {

                setState(() {
                  _isLoading = true;
                });

                final res = await sl<AuthProvider>().register(
                    context,
                    first_name: _firstNameController.text.trim(),
                    last_name: _lastNameController.text.trim(),
                    username: _usernameController.text.trim(),
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim()!
                );

                Logger().d(res);

                if(res == true){
                  if(!mounted)return;
                  ToastMessage().displayPopup(
                      context: context,
                      text: 'User account created successfully',
                      type: PopupType.success
                  );
                }else{
                  ToastMessage().displayPopup(
                      context: context, text: res.toString(), type: PopupType.failure);
                }

                setState(() {
                  _isLoading = false;
                });
                //Navigator.pushNamed(context, Routes.otpScreen);
              }),
              const Gap(10),
              BusyButton(
                height: 50,
                backgroundColor: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
                  title: 'Sign up with Phone Number', onPress: (){
                Navigator.pushNamed(context, Routes.otpScreen);
              }),
              const Gap(23),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: 'Already have an account? - Sign In  ',
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
