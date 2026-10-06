import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/button_list/views/add_button_view.dart';
import 'package:rhome/features/button_list/views/edit_button_view.dart';
import 'package:rhome/features/home/views/widgets/emprty_widget.dart';

import '../cubit/button_list_cubit.dart';

class ButtonListView extends StatelessWidget {
  const ButtonListView({super.key});

  static const routeName = '/button-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ButtonListCubit, ButtonListState>(
        listener: (context, state) {
          if (state is ButtonListError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
          }
        },
        builder: (context, state) {
          if (state is ButtonListLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is ButtonListError) {
            return Center(child: Text("Error : ${state.message}"));
          }
          if (state is ButtonListLoaded && state.buttons.isEmpty) {
            return EmprtyWidget();
          }
          if (state is ButtonListLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.buttons.length,
                    itemBuilder: (context, index) {
                      final button = state.buttons[index];
                      return Card(
                        child: ListTile(
                          leading:
                              button.image == ''
                                  ? Image.asset(
                                    'assets/icons/home.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    color: Colors.black,
                                  )
                                  : Image.file(
                                    File(button.image),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                          title: Text(button.name),
                          trailing: Text(button.id.toString()),

                          onLongPress:
                              () => showMenu(
                                position: RelativeRect.fromLTRB(0, 0, 0, 0),
                                context: context,
                                items: [
                                  PopupMenuItem(
                                    value: 'hapus',
                                    child: Text('Hapus'),
                                  ),
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                ],
                              ).then((value) {
                                if (value == 'hapus') {
                                  if (context.mounted) {
                                    context
                                        .read<ButtonListCubit>()
                                        .deleteButton(button.id ?? 0);
                                  }
                                }
                                if (value == 'edit') {
                                  if (context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                EditButtonView(button: button),
                                      ),
                                    );
                                  }
                                }
                              }),
                          onTap: () {
                            //TODO::
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushNamed(context, AddButtonView.routeName);
                    },
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
