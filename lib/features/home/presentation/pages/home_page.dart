import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/home/presentation/pages/splash.dart';
import 'package:rhome/features/home/presentation/widgets/button_widgets.dart';
import 'package:rhome/features/home/presentation/widgets/header_widget.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            // Load data pertama kali
            context.read<HomeBloc>().add(LoadRelayNamesEvent());
            return Splash();
          }

          if (state is HomeLoaded) {
            context.read<HomeBloc>().add(LoadRelayStatusEvent());
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
                          () async => context.read<HomeBloc>().add(
                            LoadRelayStatusEvent(),
                          ),
                      child: ButtonWidgets(
                        state: state,
                        length: state.relayStates.length,
                      ),
                    ),
                  ),

                  //sign name
                  Expanded(flex: 2, child: Text("Created By: Ricky Rozian")),
                ],
              ),
            );
          }

          return Scaffold(
            body: const Center(child: Text('Terjadi kesalahan.')),
          );
        },
      ),
    );
  }
}
