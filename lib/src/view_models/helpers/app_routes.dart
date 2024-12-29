import 'package:flutter/material.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/screen/home_screen.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/screen/main_screen.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/onboarding/screen/login_screen.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/onboarding/screen/register_screen.dart';

class AppRoutes {
  // Named route constants
  static const String main = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';

  // Route generator untuk menangani navigasi
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterSCreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      default:
        return MaterialPageRoute(builder: (_) => const MainScreen());
    }
  }
}
