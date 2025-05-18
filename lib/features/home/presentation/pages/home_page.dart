import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/home/presentation/widgets/button_widgets.dart';
import 'package:rhome/features/setting/pages/setting_view.dart';
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
            return Scaffold(
              body: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Image.asset("assets/icons/home.png"),
                        ),
                        SizedBox(height: 35),
                        CircularProgressIndicator(color: Colors.black),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "RHome",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 75),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is HomeLoaded) {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: PreferredSize(
                preferredSize: Size(
                  double.infinity,
                  35,
                  // MediaQuery.of(context).size.height*0.5,
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'RHome',
                        style: TextStyle(
                          color: Colors.black,

                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle,
                            color:
                                state.isConnected ? Colors.green : Colors.red,
                            size: 12,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            state.isConnected ? "Connected" : "Disconnected",
                            style: TextStyle(
                              color:
                                  state.isConnected ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed:
                            () => Navigator.pushNamed(
                              context,
                              SettingView.routeName,
                            ),
                        icon: Icon(Icons.settings),
                      ),
                    ],
                  ),
                ),
              ),
              body: Column(
                children: [
                  // Daftar relay
                  Expanded(
                    flex: 20,
                    child: buttonWidget(
                      state: state,
                      context: context,
                      lenght: state.relayStates.length,
                    ),
                  ),
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
