import 'package:flutter/material.dart';
import 'package:rhome/cores/components/components.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
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
          children: [
            SubtitleText("Ricky Rozian"),
            RegularText("email@gail.com"),
          ],
        ),
      ],
    );
  }
}
