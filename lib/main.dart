import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cores/app/app_injection.dart';
import 'cores/app/app_observer.dart';
import 'cores/app/app_providers.dart';
import 'cores/routes/routes.dart';
import 'features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      child: MaterialApp(
        onGenerateRoute: routes,
        initialRoute: SplashScreen.routeName,
        title: 'RHome',
      ),
    );
  }
}
