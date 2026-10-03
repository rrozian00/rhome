import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/setting_bloc.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is SettingError) {
          return Center(child: Text(state.message));
        }
        if (state is SettingLoaded) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 10,
            children: [
              ClipOval(
                child: CircleAvatar(
                  radius: 40,
                  child: Image.asset("assets/images/meeting-room.png"),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('John Doe'), Text('john.doe@example.com')],
              ),
            ],
          );
        }
        return Text('404');
      },
    );
  }
}
