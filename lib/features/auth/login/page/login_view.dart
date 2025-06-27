import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/auth/login/bloc/login_bloc.dart';
import 'package:rhome/features/auth/login/page/register_view.dart';
import 'package:rhome/features/home/presentation/pages/home_page.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
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
                  controller: email,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Email :",
                  ),
                ),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Pass :",
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pushReplacementNamed(context, HomePage.routeName);
                      context.read<LoginBloc>().add(
                        DoLogin(email: email.text, password: password.text),
                      );
                    },
                    child: Text("Home Page"),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: TextButton(
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterView()),
              ),
          child: Text('Register'),
        ),
      ),
    );
  }
}
