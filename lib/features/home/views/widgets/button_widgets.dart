import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../bloc/home_state.dart';

class ButtonWidgets extends StatelessWidget {
  const ButtonWidgets({super.key, required this.length, required this.states});

  final int length;
  final HomeLoaded states;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 4 : 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: isTablet ? 0.5 : 0.75,
        ),
        itemBuilder: (context, index) {
          final bloc = context.read<HomeBloc>();
          final relay = states.relayStates[index];
          return Material(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: relay == true ? Colors.green[200] : Colors.red[200],
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                if (relay) {
                  bloc.add(TurnOffHomeEvent(index));
                } else {
                  bloc.add(TurnOnHomeEvent(index));
                }
              },

              //Button
              child: AnimatedScale(
                duration: Duration(milliseconds: 300),
                scale: relay == true ? 1 : 0.95,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              child: IconButton(
                                onPressed: () {
                                  _showRenameDialog(
                                    context,
                                    index,
                                    states.relayNames[index],
                                  );
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              child: IconButton(
                                onPressed: () {
                                  _showOptionDialog(context, index);
                                },
                                icon: Icon(Icons.image),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ClipOval(
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: MediaQuery.of(context).size.width / 7,
                          child:
                              states.imagePath[index] != ''
                                  ? Image.file(
                                    File(states.imagePath[index]),
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                  )
                                  : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Image.asset("assets/icons/home.png"),
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              states.relayNames[index],
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    blurRadius: 1.0,
                                    offset: Offset(0.8, 0.8),
                                  ),
                                ],
                                color:
                                    relay == true ? Colors.green : Colors.red,
                              ),
                            ),
                            Text(
                              relay == true ? "ON" : "OFF",
                              style: TextStyle(
                                color:
                                    relay == true ? Colors.red : Colors.white,
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
        title: const Text('Rename'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              textCapitalization: TextCapitalization.words,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<HomeBloc>().add(
                RenameHomeEvent(index: index, newName: controller.text),
              );
              Navigator.pop(context);
            },
            child: const Text(
              'Save',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}

void _showOptionDialog(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Options"),
        content: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(PickImageEvent(index: index));
                Navigator.pop(context);
              },
              child: Text("Change Picture"),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(ResetImage(index));
                Navigator.pop(context);
              },
              child: Text("Reset Picture"),
            ),
          ],
        ),
      );
    },
  );
}
