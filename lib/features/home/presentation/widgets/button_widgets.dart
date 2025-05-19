import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/cores/cores.dart';
import 'package:rhome/features/home/presentation/bloc/relay_bloc.dart';
import 'package:rhome/features/home/presentation/bloc/relay_event.dart';
import 'package:rhome/features/home/presentation/bloc/relay_state.dart';

class ButtonWidgets extends StatelessWidget {
  const ButtonWidgets({
    super.key,
    required this.length,
    required this.states,
    // required this.icons,
  });

  final int length;
  final RelayLoaded states;
  // final List<String> icons;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          final bloc = context.read<RelayBloc>();
          final relay = states.relayStates[index];
          return Material(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color:
                // AppColors.red[200],
                relay == true ? AppColors.green[200] : AppColors.red[200],
            child: InkWell(
              borderRadius: BorderRadius.circular(15),

              onDoubleTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: SubtitleText("Ubah Gambar"),
                      content: Column(
                        spacing: 20,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.read<RelayBloc>().add(
                                PickImageEvent(index: index),
                              );
                              Navigator.pop(context);
                            },
                            child: RegularText(
                              "Ubah",
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<RelayBloc>().add(ResetImage(index));
                              Navigator.pop(context);
                            },
                            child: RegularText(
                              "Reset",
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              onLongPress: () {
                _showRenameDialog(context, index, states.relayNames[index]);
              },
              onTap: () {
                if (relay) {
                  bloc.add(TurnOffRelayEvent(index));
                } else {
                  bloc.add(TurnOnRelayEvent(index));
                }
              },
              child: AnimatedScale(
                duration: Duration(milliseconds: 300),
                scale: relay == true ? 1 : 0.95,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipOval(
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: MediaQuery.of(context).size.width / 7,
                          child:
                              states.imagePath[index] != ''
                                  ? Image.file(File(states.imagePath[index]))
                                  : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Image.asset(
                                      "assets/icons/home.png",
                                      color: AppColors.black,
                                    ),
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RegularText(
                              states.relayNames[index],
                              style: TextStyle(
                                color: AppColors.black,
                                // fontSize: 16,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            SubtitleText(
                              relay == true ? "ON" : "OFF",
                              style: TextStyle(
                                color:
                                    relay == true
                                        ? AppColors.red
                                        : AppColors.black[200],
                              ),
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
        },
      ),
    );
  }
}

void _showRenameDialog(BuildContext context, int index, String currentName) {
  final TextEditingController controller = TextEditingController(
    text: currentName,
  );

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        scrollable: false,
        title: const SubtitleText('Ganti Nama'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RegularTextInput(
              hintText: "Nama Relay Baru",
              controller: controller,
              textCapitalization: TextCapitalization.words,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              context.read<RelayBloc>().add(
                RenameRelayEvent(index: index, newName: controller.text),
              );
              Navigator.pop(context);
            },
            child: const Text(
              'Simpan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}
