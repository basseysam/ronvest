import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/injections/injection_container.dart';
import '../../core/navigators/route_names.dart';
import '../../features/auth/presentation/provider/auth_provider.dart';
import '../styles/app_colors.dart';
import '../../core/navigators/router.dart';
import '../../core/navigators/global.dart' as globals;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<AuthProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Ronvest',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          /*primarySwatch: const MaterialColor(
                0xff004EF1,
                AppColors.colorScratch,
              ),*/
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.transparent,
          ),
        ),
        navigatorKey: globals.appNavigator,
        initialRoute: Routes.splash,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
