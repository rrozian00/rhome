import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/cores/app/app_injection.dart';
import '../../features/auth/login/bloc/login_bloc.dart';

import '../../features/auth/register/bloc/register_bloc.dart';
import '../../features/home/presentation/bloc/relay_bloc.dart';
import '../../features/setting/bloc/setting_bloc.dart';

List<BlocProvider> appProviders = [
  BlocProvider<LoginBloc>(create: (_) => getIt<LoginBloc>()),
  BlocProvider<RegisterBloc>(create: (_) => getIt<RegisterBloc>()),
  BlocProvider<RelayBloc>(create: (_) => getIt<RelayBloc>()),
  BlocProvider<SettingBloc>(create: (_) => getIt<SettingBloc>()),
];
