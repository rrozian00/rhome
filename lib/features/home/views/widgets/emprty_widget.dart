import 'package:flutter/material.dart';
import 'package:rhome/features/setting/views/setting_view.dart';

class EmprtyWidget extends StatelessWidget {
  const EmprtyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "You don't have any button yet. Please add a button to get started.",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, SettingView.routeName);
            },
            child: Text("Add Button"),
          ),
        ],
      ),
    );
  }
}
