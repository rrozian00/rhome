import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhome/features/auth/login/page/login_view.dart';
import 'package:rhome/features/auth/register/bloc/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static const routeName = '/register';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final email = TextEditingController();
  final name = TextEditingController();
  final pass = TextEditingController();
  final pass2 = TextEditingController();
  bool _obsecureStatus = true;
  bool _obsecureStatus2 = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is RegisterSuccess) {
          Navigator.of(context).pushNamed(LoginView.routeName);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Pendaftaran akun berhasil, Silahkan Login.'),
            ),
          );
        }
      },
      child: Scaffold(
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
                  controller: name,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Nama",
                  ),
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Email",
                  ),
                ),
                TextField(
                  obscureText: _obsecureStatus,
                  controller: pass,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Password",
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          _obsecureStatus = !_obsecureStatus;
                        });
                      },
                      icon: Icon(
                        _obsecureStatus
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                TextField(
                  obscureText: _obsecureStatus2,
                  controller: pass2,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Ulangi Password",
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          _obsecureStatus2 = !_obsecureStatus2;
                        });
                      },
                      icon: Icon(
                        _obsecureStatus2
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return CircularProgressIndicator.adaptive();
                      }
                      return ElevatedButton(
                        onPressed: () {
                          context.read<RegisterBloc>().add(
                            DoRegister(
                              email: email.text,
                              password: pass.text,
                              name: name.text,
                            ),
                          );
                        },
                        child: Text("Daftar"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: TextButton(
          onPressed: () {
            Navigator.of(context).maybePop(LoginView.routeName);
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
