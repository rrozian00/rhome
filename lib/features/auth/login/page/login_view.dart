import 'package:flutter/material.dart';
import 'package:rhome/features/home/presentation/pages/home_page.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 25,
            children: [
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: "Email :",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: "Pass :",
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, HomePage.routeName);
                  },
                  child: Text("Home Page"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
