import 'package:flutter/material.dart';
import 'package:rhome/features/auth/login/page/login_view.dart';
import 'package:rhome/features/home/presentation/pages/home_page.dart';
import 'package:rhome/features/setting/pages/setting_view.dart';

Route<dynamic> routes(settings) {
  switch (settings.name) {
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case HomePage.routeName:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case SettingView.routeName:
      return MaterialPageRoute(builder: (context) => const SettingView());

    default:
      return MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text("Page Not Found")),
            body: Center(
              child: Text("Page Not Found", textAlign: TextAlign.center),
            ),
          );
        },
      );
  }
}
