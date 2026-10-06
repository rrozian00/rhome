import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/home/bloc/home_bloc.dart';
import 'package:rhome/features/home/bloc/home_state.dart';

class ButtonListView extends StatelessWidget {
  const ButtonListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.image),
              title: Text("Button ${index + 1}"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle button tap
              },
            );
          },
        );
      },
    );
  }
}
