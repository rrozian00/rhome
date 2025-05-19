import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/cores/components/text/regular_text.dart';
import 'package:rhome/features/relay/presentation/pages/splash.dart';
import 'package:rhome/features/relay/presentation/widgets/button_widgets.dart';
import 'package:rhome/features/relay/presentation/widgets/error_relay_widget.dart';
import 'package:rhome/features/relay/presentation/widgets/header_widget.dart';

import '../blocs/relay_bloc/relay_bloc.dart';
import '../blocs/relay_bloc/relay_event.dart';
import '../blocs/relay_bloc/relay_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';

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
            // Load data pertama kali
            context.read<RelayBloc>().add(LoadRelayNamesEvent());
            return Splash();
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

                  //sign name
                  Expanded(
                    flex: 2,
                    child: RegularText("Created By: Ricky Rozian"),
                  ),
                ],
              ),
            );
          }
          //jika state tidak dikenali
          return ErrorRelayWidget();
        },
      ),
    );
  }
}
