import 'package:flutter/material.dart';
import 'package:ronvest/core/navigators/route_names.dart';
import 'package:ronvest/features/dashboard/presentation/pages/user_profile.dart';
import '../../features/auth/presentation/pages/otp_screen.dart';
import '../../features/auth/presentation/pages/sign_in.dart';
import '../../features/auth/presentation/pages/sign_up.dart';
import '../../features/dashboard/presentation/pages/dashboard.dart';
import '../../features/onboarding/presentation/screens/choose_account.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return _getPageRoute(
          routeName: settings.name, viewToShow: const SplashScreen());

    case Routes.chooseAccount:
      return _getPageRoute(
          routeName: settings.name, viewToShow: const ChooseAccount());

    case Routes.signUpScreen:
      return _getPageRoute(
          routeName: settings.name, viewToShow: const SignUpScreen());

    case Routes.otpScreen:
      return _getPageRoute(
          routeName: settings.name,
          viewToShow: OTPScreen(
            data: settings.arguments as Map<dynamic, dynamic>,
          ));

    case Routes.signInScreen:
      return _getPageRoute(
          routeName: settings.name, viewToShow: const SignInScreen());

    case Routes.dashboardScreen:
      return _getPageRoute(
          routeName: settings.name, viewToShow: const DashBoard());

    case Routes.userProfile:
      return _getPageRoute(
          routeName: settings.name, viewToShow: const UserProfile());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String? routeName, Widget? viewToShow}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow!,
  );
}
