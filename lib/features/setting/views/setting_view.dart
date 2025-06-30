import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/cores/cores.dart';
import 'package:rhome/features/auth/login/page/login_view.dart';
import 'package:rhome/features/setting/bloc/setting_bloc.dart';
import 'package:rhome/features/setting/views/info_section.dart';
import 'package:rhome/features/setting/views/profile_section.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        final cs = state as SettingLoaded;
        if (cs.isLogout == true) {
          Navigator.pushReplacementNamed(context, LoginView.routeName);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: SubtitleText("Settings"),
        ),
        body: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            if (state is SettingError) {
              return Center(child: Text("Error : ${state.message}"));
            }
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
                              _showIpAddressDialog(context, state);
                            },
                          ),
                          ListTile(
                            leading: Icon(CupertinoIcons.arrow_left),
                            title: RegularText("Logout"),
                            onTap: () {
                              context.read<SettingBloc>().add(DoLogout());
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
      ),
    );
  }
}

_showIpAddressDialog(BuildContext context, SettingState state) {
  showDialog(
    context: context,
    builder: (context) {
      final currentState = state as SettingLoaded;
      final ipC = TextEditingController(text: currentState.ipAdress);
      return AlertDialog(
        content: Column(
          spacing: 30,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Ubah alamat IP",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            TextField(
              controller: ipC,
              decoration: InputDecoration(hintText: "Masukkan alamat IP baru"),
            ),
            Text("Example : 192.168.0.110"),
            ElevatedButton(
              onPressed: () {
                context.read<SettingBloc>().add(
                  UpdateIpAddress(ipAddress: ipC.text),
                );
                Navigator.pop(context);
                context.read<SettingBloc>().add(GetAppVersion());
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      );
    },
  );
}
