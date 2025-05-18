import 'package:flutter/material.dart';
import 'package:rhome/features/home/presentation/bloc/home_state.dart';
import 'package:rhome/features/setting/pages/setting_view.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.state});

  final HomeLoaded state;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                color: state.isConnected ? Colors.green : Colors.red,
                size: 12,
              ),
              const SizedBox(width: 8),
              Text(
                state.isConnected ? "Connected" : "Disconnected",
                style: TextStyle(
                  color: state.isConnected ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed:
                () => Navigator.pushNamed(context, SettingView.routeName),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
