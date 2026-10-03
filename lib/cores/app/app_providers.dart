import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/bloc/home_bloc.dart';
import '../../features/setting/bloc/setting_bloc.dart';
import 'app_injection.dart';

List<BlocProvider> appProviders = [
  BlocProvider<HomeBloc>(create: (_) => getIt<HomeBloc>()),
  BlocProvider<SettingBloc>(create: (_) => getIt<SettingBloc>()),
];
