import 'package:flutter/material.dart';
import 'package:rhome/features/home/views/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/splah';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        // Navigator.pushReplacementNamed(context, HomeView.routeName);
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeView.routeName,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/icons/home.png",
              color: Colors.black,
              height: 90,
              width: 90,
            ),
            Text(
              "RHome",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text('by: Ricky Rozian'),
            SizedBox(height: 30),
            CircularProgressIndicator.adaptive(),
          ],
        ),
      ),
    );
  }
}
