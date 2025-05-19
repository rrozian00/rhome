import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/cores/app/routes.dart';
import 'package:rhome/cores/preferences/colors.dart';
import 'package:rhome/cores/preferences/themes/light_theme.dart';
import 'package:rhome/features/home/presentation/bloc/relay_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RelayBloc(),
      child: MaterialApp(
        onGenerateRoute: routes,
        title: 'RHome',
        theme: LightTheme(AppColors.black).theme,
      ),
    );
  }
}
