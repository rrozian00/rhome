import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import '../../features/home/bloc/home_bloc.dart';
import '../../features/repositories/image_repository.dart';
import '../../features/repositories/relay_repository.dart';
import '../../features/repositories/local_repository.dart';
import '../../features/setting/bloc/setting_bloc.dart';

final getIt = GetIt.instance;

void setUpLocator() {
  getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());

  getIt.registerLazySingleton<LocalRepository>(() => LocalRepository());

  getIt.registerLazySingleton<RelayRepository>(() => RelayRepository());

  getIt.registerLazySingleton<ImageRepository>(
    () => ImageRepository(picker: getIt<ImagePicker>()),
  );

  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      relayRepo: getIt<RelayRepository>(),
      imageRepo: getIt<ImageRepository>(),
      localRepo: getIt<LocalRepository>(),
    ),
  );

  getIt.registerFactory<SettingBloc>(
    () => SettingBloc(
      relayRepo: getIt<RelayRepository>(),
      localRepo: getIt<LocalRepository>(),
    ),
  );
}
