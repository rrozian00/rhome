import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/app/routes.dart';
import 'package:rhome/cores/preferences/colors.dart';
import 'package:rhome/cores/preferences/themes/light_theme.dart';
import 'package:rhome/features/home/bloc/home_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: MaterialApp(
        // initialRoute: "/",
        // routes: {
        //   "/": (context) => HomeView(),
        //   "/setting": (context) => SettingView(),
        // },
        onGenerateRoute: routes,
        title: 'RHome',
        theme: LightTheme(AppColors.green).theme,
      ),
    );
  }
}
