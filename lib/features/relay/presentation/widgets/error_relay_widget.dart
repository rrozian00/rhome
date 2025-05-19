import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/cores/components/components.dart';
import 'package:rhome/cores/preferences/preferences.dart';
import 'package:rhome/features/relay/presentation/blocs/relay_bloc/relay_bloc.dart';
import 'package:rhome/features/relay/presentation/blocs/relay_bloc/relay_event.dart';

class ErrorRelayWidget extends StatelessWidget {
  const ErrorRelayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh:
              () async => context.read<RelayBloc>().add(LoadRelayNamesEvent()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 3),
                Icon(AppIcons.help, size: 80, color: AppColors.red),
                const Center(
                  child: Column(
                    children: [
                      HeadingText("Terjadi kesalahan !!!"),
                      RegularText(
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.black),
                        'Silahkan scroll kebawah unuk mencoba lagi !',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
