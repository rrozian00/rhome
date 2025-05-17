import 'package:flutter/material.dart';
import 'package:rhome/features/setting/pages/profile_page.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text("Settings"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () => Navigator.pushNamed(context, ProfilePage.routeName),
            ),
            ListTile(
              leading: Icon(Icons.near_me_rounded),
              title: Text("Customize IP"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
