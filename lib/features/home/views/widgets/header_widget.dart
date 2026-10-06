import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/home/bloc/home_event.dart';
import 'package:rhome/features/setting/bloc/setting_bloc.dart';

import '../../../setting/views/setting_view.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_state.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          const Text(
            'RHome',

            style: TextStyle(
              color: Colors.black,

              fontSize: 20,

              fontWeight: FontWeight.w600,
            ),
          ),

          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final isConnected =
                  state is HomeLoaded ? state.isConnected : false;

              return Row(
                children: [
                  Icon(
                    Icons.circle,

                    color: isConnected ? Colors.green : Colors.red,

                    size: 12,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    isConnected ? "Connected" : "Disconnected",

                    style: TextStyle(
                      color: isConnected ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              );
            },
          ),

          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<HomeBloc>().add(LoadRelayStatusEvent());
                },
                icon: Icon(Icons.refresh),
              ),

              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SettingView.routeName);
                  context.read<SettingBloc>().add(GetSettings());
                },

                icon: const Icon(Icons.settings, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
