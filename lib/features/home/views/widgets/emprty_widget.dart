import 'package:flutter/material.dart';

import '../../../button_list/views/add_button_view.dart';

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
              Navigator.pushNamed(context, AddButtonView.routeName);
            },
            child: Text("Add Button"),
          ),
        ],
      ),
    );
  }
}
