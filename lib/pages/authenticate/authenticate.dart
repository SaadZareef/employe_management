import 'package:flutter/material.dart';
import 'package:practice/pages/authenticate/login_page.dart';
import 'package:practice/pages/authenticate/register_page.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;
  void toggleView() {
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return LoginPage(toggleView: toggleView);
    } else {
      return RegisterPage(
        toggleView: toggleView,
      );
    }
  }
}
