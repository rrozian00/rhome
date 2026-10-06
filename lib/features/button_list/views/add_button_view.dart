import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/button_list/cubit/button_list_cubit.dart';
import 'package:rhome/cores/models/button_model.dart';

class AddButtonView extends StatelessWidget {
  const AddButtonView({super.key});

  static const routeName = '/add-button';

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return BlocListener<ButtonListCubit, ButtonListState>(
      listener: (context, state) {
        if (state is ButtonListError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Add Button')),
        body: Column(
          children: [
            TextField(
              textCapitalization: TextCapitalization.words,
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Button Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<ButtonListCubit>().addButton(
                  ButtonModel(name: nameController.text, image: ''),
                );
                Navigator.pop(context);
              },
              child: Text('Add Button'),
            ),
          ],
        ),
      ),
    );
  }
}
