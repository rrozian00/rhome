import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/cores/cores.dart';
import 'package:rhome/features/setting/bloc/setting_bloc.dart';
import 'package:rhome/features/setting/pages/profile_page.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: SubtitleText("Settings"),
      ),
      body: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state is SettingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.person),
                        title: RegularText("Profile"),
                        onTap:
                            () => Navigator.pushNamed(
                              context,
                              ProfilePage.routeName,
                            ),
                      ),
                      ListTile(
                        leading: Icon(Icons.near_me_rounded),
                        title: RegularText("Customize IP"),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              final currentState = state as SettingLoaded;
                              final ipC = TextEditingController(
                                text: currentState.ipAdress,
                              );
                              return AlertDialog(
                                content: Column(
                                  spacing: 30,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Ubah alamat IP",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextField(
                                      controller: ipC,
                                      decoration: InputDecoration(
                                        hintText: "Masukkan alamat IP baru",
                                      ),
                                    ),
                                    Text("Ex : 192.168.0.110"),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<SettingBloc>().add(
                                          SaveIpAddress(ipAddress: ipC.text),
                                        );
                                        Navigator.pop(context);
                                        context.read<SettingBloc>().add(
                                          GetAppVersion(),
                                        );
                                      },
                                      child: Text("Simpan"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder<SettingBloc, SettingState>(
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
                            style: TextStyle(color: AppColors.textDisabled),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
