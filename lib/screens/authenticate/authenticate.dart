import 'package:flutter/material.dart';
import 'package:mybook/screens/authenticate/register.dart';
import 'package:mybook/screens/authenticate/sign_in.dart';

// Allows the user to sign in or register.
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true; // Shows the sign in by default.

  // Allows the user to toggle between sign in and register screens by changing
  // the showSignIn value.
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignIn(toggleView: toggleView)
        : Register(toggleView: toggleView);
  }
}
