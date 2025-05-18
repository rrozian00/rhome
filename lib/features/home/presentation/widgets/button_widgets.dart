import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/home/presentation/bloc/home_bloc.dart';
import 'package:rhome/features/home/presentation/bloc/home_event.dart';
import 'package:rhome/features/home/presentation/bloc/home_state.dart';

class ButtonWidgets extends StatelessWidget {
  const ButtonWidgets({super.key, required this.length, required this.state});

  final int length;
  final HomeLoaded state;
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
        ),
        itemBuilder: (context, index) {
          final bloc = context.read<HomeBloc>();
          final relay = state.relayStates[index];
          return GestureDetector(
            onDoubleTap: () {
              context.read<HomeBloc>().add(PickImageEvent(index: index));
            },
            onLongPress: () {
              _showRenameDialog(context, index, state.relayNames[index]);
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
              child: Stack(
                children: [
                  Center(
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(15),
                      child:
                          state.imagePath[index] != ""
                              ? Image.file(File(state.imagePath[index]))
                              : Image.asset(
                                "assets/icons/home.png",
                                color:
                                    relay == true
                                        ? Colors.green[700]
                                        : Colors.red[700],
                              ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                relay == true
                                    ? Colors.green[700]
                                    : Colors.red[700],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  state.relayNames[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  relay == true ? "ON" : "OFF",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
        title: const Text('Ganti Nama Relay'),
        content: TextField(
          textCapitalization: TextCapitalization.words,
          controller: controller,
          decoration: const InputDecoration(hintText: 'Nama baru'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              context.read<HomeBloc>().add(
                RenameRelayEvent(index: index, newName: controller.text),
              );
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      );
    },
  );
}
