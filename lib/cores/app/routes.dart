import 'package:flutter/material.dart';
import 'package:rhome/features/relay/presentation/pages/home_page.dart';
import 'package:rhome/features/setting/pages/profile_page.dart';
import 'package:rhome/features/setting/pages/setting_view.dart';

Route<dynamic> routes(settings) {
  switch (settings.name) {
    case HomePage.routeName:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case SettingView.routeName:
      return MaterialPageRoute(builder: (context) => const SettingView());
    case ProfilePage.routeName:
      return MaterialPageRoute(builder: (context) => const ProfilePage());
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
