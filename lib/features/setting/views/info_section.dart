import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/setting_bloc.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (context.mounted) {
          if (state is SettingError) {
            return Text(state.message);
          }
        }
        final curentState = state as SettingLoaded;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("IP Address : ${curentState.ipAdress}"),
              Text(
                "App Version : ${curentState.appVersion}",
                style: TextStyle(color: Colors.grey),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  "By : Ricky Rozian",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
