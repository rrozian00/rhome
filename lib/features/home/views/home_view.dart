import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/home/views/widgets/emprty_widget.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

import 'widgets/button_widgets.dart';
import 'widgets/error_relay_widget.dart';
import 'widgets/header_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          MediaQuery.of(context).size.height * .5,
        ),

        child: HeaderWidget(),
      ),

      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is HomeLoaded && state.buttons.isEmpty) {
            return EmprtyWidget();
          }
          if (state is HomeError) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(LoadRelayStatusEvent());
              },

              child: ErrorRelayWidget(message: state.message),
            );
          }
          if (state is HomeLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(LoadRelayStatusEvent());
              },

              child: ButtonWidgets(
                buttons: state.buttons,
                buttonStates: state.relayStates,
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
