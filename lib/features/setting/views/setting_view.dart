import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/button_list/views/button_list_view.dart';
import 'package:rhome/features/button_list/cubit/button_list_cubit.dart';
import '../bloc/setting_bloc.dart';
import 'info_section.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text("Settings"),
      ),
      body: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state is SettingError) {
            return Center(child: Text("Error : ${state.message}"));
          }
          if (state is SettingLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 30,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.list),
                          title: Text("Button List"),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ButtonListView.routeName,
                            );
                            context.read<ButtonListCubit>().loadButtons();
                          },
                        ),

                        ListTile(
                          leading: Icon(Icons.help),
                          title: Text("Customize IP"),
                          onTap: () {
                            _showIpAddressDialog(context, state);
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
            Text("Example : 192.168.1.11"),
            ElevatedButton(
              onPressed: () {
                context.read<SettingBloc>().add(
                  UpdateIpAddress(ipAddress: ipC.text),
                );
                Navigator.pop(context);
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      );
    },
  );
}
