import 'package:flutter/material.dart';

import '../../features/home/views/home_view.dart';
import '../../features/setting/views/setting_view.dart';
import '../../features/splash/splash_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  HomeView.routeName: (context) => const HomeView(),
  SettingView.routeName: (context) => const SettingView(),

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
