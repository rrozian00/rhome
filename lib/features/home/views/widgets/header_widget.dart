import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/setting/bloc/setting_bloc.dart';

import '../../../setting/views/setting_view.dart';
import '../../bloc/home_state.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.state});

  final HomeLoaded state;

  @override
  Widget build(BuildContext context) {
    bool isConnected = false;

    if (state.isConnected == true) {
      isConnected = state.isConnected;
    }

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

          Row(
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
          ),

          Row(
            children: [
              _showHelpDialog(context),

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

Widget _showHelpDialog(BuildContext context) {
  return IconButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Instruction"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text("Help"),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Oke", style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          );
        },
      );
    },
    icon: Icon(Icons.help_outline_outlined, color: Colors.black),
  );
}
