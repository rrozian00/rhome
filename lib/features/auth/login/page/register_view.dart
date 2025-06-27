import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/auth/login/bloc/login_bloc.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 25,
            children: [
              TextField(
                controller: email,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: "Email :",
                ),
              ),
              TextField(
                controller: pass,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: "Pass :",
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(
                      DoLogin(email: email.text, password: pass.text),
                    );
                  },
                  child: Text("Daftar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
