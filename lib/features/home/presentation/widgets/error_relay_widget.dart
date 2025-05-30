import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/cores/components/components.dart';
import 'package:rhome/cores/preferences/preferences.dart';
import 'package:rhome/features/home/presentation/bloc/relay_bloc.dart';
import 'package:rhome/features/home/presentation/bloc/relay_event.dart';
import 'package:rhome/features/setting/bloc/setting_bloc.dart';
import 'package:rhome/features/setting/pages/setting_view.dart';

class ErrorRelayWidget extends StatelessWidget {
  const ErrorRelayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        actions: [
          IconButton(
            onPressed:
                () async =>
                    context.read<RelayBloc>().add(LoadRelayNamesEvent()),
            icon: Icon(CupertinoIcons.refresh, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              context.read<SettingBloc>().add(GetAppVersion());
              context.read<SettingBloc>().add(GetIpAddress());
              Navigator.pushNamed(context, SettingView.routeName);
            },
            icon: Icon(AppIcons.settings, color: Colors.black),
          ),
        ],
      ),
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
