import 'package:flutter/material.dart';
import 'package:rhome/cores/components/components.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const routeName = "/settings/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(backgroundColor: Colors.grey[200], title: Text("Profile")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RegularText("Profile name"),
                      RegularText("email@gail.com"),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Ubah Profil")),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Ubah Password"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
