import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    log("CREATE : ${bloc.runtimeType}");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    log("EVENT : ${bloc.runtimeType} -> $event");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    log("CHANGE : ${bloc.runtimeType}");

    log("FROM : ${change.currentState}");

    log("TO   : ${change.nextState}");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log("ERROR : ${bloc.runtimeType}");

    log(error.toString());

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    log("CLOSE : ${bloc.runtimeType}");

    super.onClose(bloc);
  }
}
