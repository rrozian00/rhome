import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/button_list/cubit/button_list_cubit.dart';
import 'package:rhome/features/home/bloc/home_event.dart';

import '../../features/home/bloc/home_bloc.dart';
import '../../features/setting/bloc/setting_bloc.dart';
import 'app_injection.dart';

List<BlocProvider> appProviders = [
  BlocProvider<HomeBloc>(
    create: (_) => getIt<HomeBloc>()..add(LoadRelayStatusEvent()),
  ),
  BlocProvider<SettingBloc>(
    create: (_) => getIt<SettingBloc>()..add(GetSettings()),
  ),
  BlocProvider<ButtonListCubit>(create: (_) => getIt<ButtonListCubit>()),
];
