import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/relay_bloc.dart';
import '../bloc/relay_event.dart';
import '../bloc/relay_state.dart';
import '../widgets/button_widgets.dart';
import '../widgets/error_relay_widget.dart';
import '../widgets/header_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocListener<RelayBloc, RelayState>(
      listener: (context, state) {
        if (state is RelayError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocBuilder<RelayBloc, RelayState>(
        builder: (context, state) {
          if (state is RelayInitial) {
            context.read<RelayBloc>().add(LoadRelayNamesEvent());
          }

          if (state is RelayLoading) {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          }

          if (state is RelayError &&
              state.message.trim() == "Image is not picked") {
            context.read<RelayBloc>().add(LoadRelayNamesEvent());
            return Scaffold(
              backgroundColor: Colors.grey[200],
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          }

          if (state is RelayError) {
            return Scaffold(
              backgroundColor: Colors.grey[200],

              body: Column(
                children: [
                  // Daftar relay
                  Expanded(
                    flex: 20,
                    child: RefreshIndicator(
                      onRefresh:
                          () async => context.read<RelayBloc>().add(
                            LoadRelayStatusEvent(),
                          ),
                      child: ErrorRelayWidget(),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is RelayLoaded) {
            context.read<RelayBloc>().add(LoadRelayStatusEvent());
            return Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: PreferredSize(
                preferredSize: Size(
                  double.infinity,
                  MediaQuery.of(context).size.height * 0.5,
                ),
                child:
                // header widget
                HeaderWidget(state: state),
              ),
              body: Column(
                children: [
                  // Daftar relay
                  Expanded(
                    flex: 20,
                    child: RefreshIndicator(
                      onRefresh:
                          () async => context.read<RelayBloc>().add(
                            LoadRelayStatusEvent(),
                          ),
                      child: ButtonWidgets(
                        states: state,
                        length: state.relayStates.length,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Text('404');
        },
      ),
    );
  }
}
