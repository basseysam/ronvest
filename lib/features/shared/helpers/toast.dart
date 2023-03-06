import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ronvest/features/shared/helpers/popup.dart';

import '../../../app/styles/app_colors.dart';
import '../../../core/constants/fonts.dart';


class ToastMessage {
  displayPopup(
      {required BuildContext context,
        required String text,
        VoidCallback? onPop,
        PopupType type = PopupType.success,
        MainAxisAlignment mainAxisAlignment = MainAxisAlignment.end}) {
    var mounted = true;
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        var popDialog = () {
          mounted = false;
          if (onPop == null) {
            Navigator.pop(context);
          } else {
            onPop.call();
          }
        };
        var success = type == PopupType.success;
        return WillPopScope(
          onWillPop: () {
            mounted = false;
            if (onPop == null) {
              return Future.value(true);
            } else {
              onPop.call();
              return Future.value(false);
            }
          },
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TweenAnimationBuilder<double>(
                builder: (context, value, child) => Transform.translate(
                    offset: Offset(0, value), child: child!),
                duration: const Duration(seconds: 1),
                tween: Tween(begin: 24, end: 0),
                curve: Curves.bounceOut,
                onEnd: () async =>
                await Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) popDialog();
                }),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(20),
                    color: type == PopupType.success ? Colors.white : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 15, bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          success ?
                          SvgPicture.asset('assets/icons/error.svg', color: AppColors.primaryColor,) :
                          SvgPicture.asset('assets/icons/error.svg') ,

                         /* Icon(
                            success
                                ? Icons.check_circle
                                : Icons.remove_circle_outlined,
                            color: Colors.white,
                          ),*/
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: Text(
                              text,
                              style:  TextStyle(
                                  color: success ?  AppColors.primaryColor : const Color(0xffcc0022),
                                  fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: AppFonts.nunitoSansRegular
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: popDialog,
                              icon: const Icon(Icons.close, size: 12, color: Colors.grey,),
                              padding: const EdgeInsets.all(6),
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(10),
            ],
          ),
        );
      },
    );
  }
}