import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cores/app/app_injection.dart';
import 'cores/app/app_providers.dart';
import 'cores/app/routes.dart';
import 'cores/helpers/app_bloc_observer.dart';
import 'cores/preferences/colors.dart';
import 'cores/preferences/themes/light_theme.dart';
import 'features/auth/login/bloc/login_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: appProviders,
      child: Builder(
        builder: (context) {
          context.read<LoginBloc>().add(CheckAuth());

          return MaterialApp(
            onGenerateRoute: routes,
            // initialRoute: LoginView.routeName,
            title: 'RHome',
            theme: LightTheme(AppColors.black).theme,
          );
        },
      ),
    );
  }
}
