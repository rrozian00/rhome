import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/cores/cores.dart';
import 'package:rhome/features/setting/bloc/setting_bloc.dart';
import 'package:rhome/features/setting/pages/info_section.dart';
import 'package:rhome/features/setting/pages/profile_section.dart';

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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 30,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileSection(),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(AppIcons.edit),
                          title: RegularText("Ubah Profil"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(AppIcons.coupon),
                          title: RegularText("Ubah Password"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(AppIcons.help),
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
                  InfoSection(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
