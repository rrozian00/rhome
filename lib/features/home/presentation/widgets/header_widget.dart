import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/cores/cores.dart';
import 'package:rhome/features/home/presentation/bloc/relay_state.dart';
import 'package:rhome/features/setting/bloc/setting_bloc.dart';
import 'package:rhome/features/setting/pages/setting_view.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.state});

  final RelayLoaded state;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SubtitleText(
            'RHome',
            style: TextStyle(
              color: AppColors.black,

              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.circle,
                color: state.isConnected ? AppColors.green : AppColors.red,
                size: 12,
              ),
              const SizedBox(width: 8),
              RegularText(
                state.isConnected ? "Connected" : "Disconnected",
                style: TextStyle(
                  color: state.isConnected ? AppColors.green : AppColors.red,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _showDialog(context);
                },
                icon: Icon(Icons.help_outline_outlined, color: AppColors.black),
              ),
              IconButton(
                onPressed: () {
                  context.read<SettingBloc>().add(GetAppVersion());
                  Navigator.pushNamed(context, SettingView.routeName);
                },
                icon: Icon(AppIcons.settings, color: AppColors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: SubtitleText("Instruction"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                RegularText("1. "),
                Expanded(
                  child: RegularText(
                    "Klik dan tahan 2 detik untuk mengubah Nama Ruang.",
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                RegularText("2. "),
                Expanded(
                  child: RegularText(
                    "Klik 2x (dua kali) untuk mengubah Ikon/Gambar.",
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: RegularText(
                "Oke",
                style: TextStyle(color: AppColors.green),
              ),
            ),
          ],
        ),
      );
    },
  );
}
