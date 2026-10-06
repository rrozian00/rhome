import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import '../../features/home/bloc/home_bloc.dart';
import '../../features/repositories/local_repository.dart';
import '../../features/setting/bloc/setting_bloc.dart';
import '../helper/http_response_helper.dart';

final getIt = GetIt.instance;

void setUpLocator() {
  getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());

  getIt.registerLazySingleton<LocalRepository>(() => LocalRepository());

  getIt.registerLazySingleton<HttpResponseHelper>(() => HttpResponseHelper());

  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      httpResponseHelper: getIt<HttpResponseHelper>(),
      imagePicker: getIt<ImagePicker>(),
      localRepo: getIt<LocalRepository>(),
    ),
  );

  getIt.registerFactory<SettingBloc>(
    () => SettingBloc(localRepo: getIt<LocalRepository>()),
  );
}
