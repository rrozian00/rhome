import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

import 'widgets/button_widgets.dart';
import 'widgets/error_relay_widget.dart';
import 'widgets/header_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(LoadRelayStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          MediaQuery.of(context).size.height * .5,
        ),

        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is! HomeLoaded) {
              return const SizedBox();
            }

            return HeaderWidget(state: state);
          },
        ),
      ),

      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is HomeError) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(LoadRelayStatusEvent());
              },

              child: ErrorRelayWidget(message: state.message),
            );
          }

          // if (state.isConnected == false) {
          //   return RefreshIndicator(
          //     onRefresh: () async {
          //       context.read<HomeBloc>().add(LoadRelayStatusEvent());
          //     },

          //     child: ErrorRelayWidget(message: state.message),
          //   );
          // }

          if (state is HomeLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(LoadRelayStatusEvent());
              },

              child: ButtonWidgets(
                states: state,
                length: state.relayStates.length,
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
