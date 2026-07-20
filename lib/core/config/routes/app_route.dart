import 'package:event_app/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:event_app/core/config/routes/app_routes_name.dart';

import '../../../modules/Authentication/forget_password_screen.dart';
import '../../../modules/Authentication/login_screen.dart';
import '../../../modules/Authentication/register_screen.dart';
import '../../../modules/Onboardingscreens/on_boarding_screen.dart';
import '../../../modules/layout/layout_screen_view.dart';

abstract class AppRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.initial:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case AppRoutesName.layout:
        return MaterialPageRoute(
          builder: (context) => const LayoutScreenView(),
        );
      case AppRoutesName.onBoarding:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreens(),
        );
      case AppRoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
        case AppRoutesName.register:
          return MaterialPageRoute(builder: (context) => const RegisterScreen());
          case AppRoutesName.forgetPassword:
            return MaterialPageRoute(builder: (context) => const ForgetPasswordScreen());
    }
    return null;
  }
}
