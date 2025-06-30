import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/auth/login/bloc/login_bloc.dart';
import 'package:rhome/features/auth/register/view/register_view.dart';
import 'package:rhome/features/home/presentation/views/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const routeName = "/";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final email = TextEditingController(text: 'rrozian00@gmail.com');
  final password = TextEditingController(text: '123123');

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is UserLogged) {
          Navigator.pushReplacementNamed(context, HomeView.routeName);
        }
        if (state is UserLogout) {
          Navigator.pushReplacementNamed(context, LoginView.routeName);
        }
        if (state is LoginSuccess) {
          Navigator.of(context).pushReplacementNamed(HomeView.routeName);
        }
        if (state is LoginFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
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
                    hintText: "Email",
                  ),
                ),
                TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Password",
                  ),
                ),
                Center(
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }

                      return ElevatedButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(
                            DoLogin(email: email.text, password: password.text),
                          );
                        },
                        child: Text("Login"),
                      );
                    },
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
