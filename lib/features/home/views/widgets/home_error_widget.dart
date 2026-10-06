import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';

class HomeErrorWidget extends StatelessWidget {
  final String message;
  const HomeErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return RefreshIndicator(
          onRefresh:
              () async => context.read<HomeBloc>().add(LoadRelayStatusEvent()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 3.5),
                Icon(Icons.warning_rounded, size: 80, color: Colors.red),
                Center(
                  child: Text(message, style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
