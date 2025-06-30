import 'package:get_it/get_it.dart';
import 'package:rhome/features/auth/login/bloc/login_bloc.dart';
import 'package:rhome/features/auth/register/bloc/register_bloc.dart';
import 'package:rhome/features/auth/repositories/auth_repository.dart';
import 'package:rhome/features/home/data/local/image_repository.dart';
import 'package:rhome/features/home/data/remote/home_repository.dart';
import 'package:rhome/features/home/presentation/bloc/relay_bloc.dart';
import 'package:rhome/features/setting/bloc/setting_bloc.dart';
import 'package:rhome/features/setting/repositories/setting_repository.dart';

final getIt = GetIt.instance;

void setUpLocator() {
  //Singleton
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepository());
  getIt.registerLazySingleton<ImageRepository>(() => ImageRepository());
  getIt.registerLazySingleton<SettingRepository>(() => SettingRepository());

  //Factory
  print("Registering RegisterBloc");
  getIt.registerFactory(() => RegisterBloc(authRepo: getIt<AuthRepository>()));

  print("Registering LoginBloc");
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(authRepo: getIt<AuthRepository>()),
  );

  print("Registering SettingBloc");
  getIt.registerFactory<SettingBloc>(
    () => SettingBloc(
      homeRepo: getIt<HomeRepository>(),
      settingRepo: getIt<SettingRepository>(),
      authRepo: getIt<AuthRepository>(),
    ),
  );

  print("Registering RelayBloc");
  getIt.registerFactory<RelayBloc>(
    () => RelayBloc(
      homeRepo: getIt<HomeRepository>(),
      imageRepo: getIt<ImageRepository>(),
      settingRepo: getIt<SettingRepository>(),
    ),
  );
}
