import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ronvest/features/auth/domain/usecases/register_usecase.dart';
import 'package:ronvest/features/auth/domain/usecases/verify_usecase.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/navigators/route_names.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/flushbar_notification.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecases/clear_saved_data_usecase.dart';
import '../../domain/usecases/get_saved_data_usecase.dart';
import '../../domain/usecases/login_usecase.dart';

@lazySingleton
class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required this.loginUsecase,
    required this.getSavedDataUsecase,
    required this.clearSavedDataUsecase,
    required this.verifyUsecase,
    required this.registerUsecase,
  });

  late final LoginUsecase loginUsecase;
  late final GetSavedDataUsecase getSavedDataUsecase;
  late final ClearSavedDataUsecase clearSavedDataUsecase;
  late final VerifyUsecase verifyUsecase;
  late final RegisterUsecase registerUsecase;
  UserEntity? userEntity;

  Future login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    final result = await loginUsecase(
      LoginParams(email: email, password: password)
    );
    return result.fold(
      (l) {
        userEntity = null;
        Logger().d(result);
        return FailureToMessage.mapFailureToMessage(l);
      },
      (r) async {
        userEntity = r;
        Logger().d(userEntity);
        notifyListeners();
        return true;
      },
    );
  }

  Future verify(
      BuildContext context, {
        required String email,
        required String email_code,
      }) async {
    final result = await verifyUsecase(
        VerifyParams(email: email, email_code: email_code)
    );
    return result.fold(
          (l) {
        userEntity = null;

        return FailureToMessage.mapFailureToMessage(l);
      },
          (r) async {
        userEntity = r;
        Logger().d(userEntity);
        notifyListeners();
        return true;
      },
    );
  }

  Future register(
      BuildContext context, {
        required String first_name,
        required String last_name,
        required String username,
        required String email,
        required String password,
      }) async {
    final result = await registerUsecase(
        RegisterParams(
            first_name: first_name,
            last_name: last_name,
            username: username,
            email: email,
            password: password)
    );
    Logger().d(result);
    return result.fold(
          (l) {
        userEntity = null;
        Logger().d(result);
       /* FlushBarNotification.showErrorMessage(
          context: context,
          message: FailureToMessage.mapFailureToMessage(l),
        );*/
        return FailureToMessage.mapFailureToMessage(l);
      },
          (r) async {
        //userEntity = r;
        notifyListeners();
        Logger().d(result);
        Map data = {
          'email' : email,
          'code' : r
        };
        Navigator.pushNamed(context, Routes.otpScreen, arguments: data );
        return true;
      },
    );
  }



  Future<bool> isUserLoggedIn(BuildContext context) async {
    final res = await getSavedDataUsecase(
      NoParams(),
    );
    return res.fold(
      (l) => false,
      (r) {
        userEntity = r;
        notifyListeners();
        return true;
      },
    );
  }

  void logout(BuildContext context) async {
    final res = await clearSavedDataUsecase(
      NoParams(),
    );
    if (res.isRight()) {
      await Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.signInScreen,
        (route) => false,
      );

      userEntity = null;
      notifyListeners();
    }
  }
}
