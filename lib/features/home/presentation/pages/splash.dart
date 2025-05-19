import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Image.asset("assets/icons/home.png"),
                ),
                SizedBox(height: 35),
                CircularProgressIndicator(color: Colors.black),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "RHome",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 75),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
