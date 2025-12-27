import 'package:flutter/material.dart';
import 'package:rhome/features/auth/login/page/login_view.dart';
import 'package:rhome/features/auth/register/view/register_view.dart';
import 'package:rhome/features/home/presentation/views/home_view.dart';
import 'package:rhome/features/setting/views/setting_view.dart';
import 'package:rhome/features/splash/splash_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  LoginView.routeName: (context) => const LoginView(),
  HomeView.routeName: (context) => const HomeView(),
  SettingView.routeName: (context) => const SettingView(),
  RegisterView.routeName: (context) => const RegisterView(),
  SplashScreen.routeName: (context) => const SplashScreen(),
};

Route<dynamic> routes(RouteSettings settings) {
  final builder = appRoutes[settings.name];
  if (builder != null) {
    return MaterialPageRoute(builder: builder, settings: settings);
  }

  // Fallback jika route tidak ditemukan
  return MaterialPageRoute(
    builder:
        (context) => Scaffold(
          appBar: AppBar(title: const Text("Page Not Found")),
          body: const Center(child: Text("Page Not Found")),
        ),
  );
}
