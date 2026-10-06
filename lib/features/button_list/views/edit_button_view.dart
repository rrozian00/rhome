import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rhome/features/button_list/cubit/button_list_cubit.dart';
import 'package:rhome/cores/models/button_model.dart';
import 'package:rhome/features/home/bloc/home_bloc.dart';
import 'package:rhome/features/home/bloc/home_event.dart';

class EditButtonView extends StatefulWidget {
  const EditButtonView({super.key, required this.button});

  final ButtonModel button;

  @override
  State<EditButtonView> createState() => _EditButtonViewState();
}

class _EditButtonViewState extends State<EditButtonView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  XFile? pickedImage;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.button.name;
    imageController.text = widget.button.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            TextField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(labelText: "Button Name"),
              controller: nameController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Button Image"),
              controller: imageController,
            ),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                pickedImage = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedImage != null) {
                  setState(() {
                    imageController.text = pickedImage!.path;
                  });
                }
              },
              child: Text("Pilih Gambar"),
            ),
            ElevatedButton(
              onPressed: () {
                final buttonData = widget.button.copyWith(
                  image: imageController.text,
                  name: nameController.text,
                );
                context.read<ButtonListCubit>().updateButton(buttonData);
                context.read<HomeBloc>().add(LoadRelayStatusEvent());

                Navigator.pop(context);
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
