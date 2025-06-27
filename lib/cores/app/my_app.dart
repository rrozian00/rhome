import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/cores/app/routes.dart';
import 'package:rhome/cores/preferences/colors.dart';
import 'package:rhome/cores/preferences/themes/light_theme.dart';
import 'package:rhome/features/auth/login/bloc/login_bloc.dart';
import 'package:rhome/features/auth/login/page/login_view.dart';
import 'package:rhome/features/home/presentation/bloc/relay_bloc.dart';
import 'package:rhome/features/setting/bloc/setting_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RelayBloc()),
        BlocProvider(create: (context) => SettingBloc()),
        BlocProvider(create: (context) => LoginBloc()),
      ],
      child: MaterialApp(
        onGenerateRoute: routes,
        initialRoute: LoginView.routeName,
        title: 'RHome',
        theme: LightTheme(AppColors.black).theme,
      ),
    );
  }
}
