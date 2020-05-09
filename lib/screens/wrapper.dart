import 'package:flutter/material.dart';
import 'package:mybook/screens/authenticate/authenticate.dart';
import 'package:mybook/services/auth_service.dart';
import 'package:mybook/widgets/bottom_nav_bar.dart';

// Wraps the authentication and the home screens.
// If the user is already logged in we display the home screen. If the user is not
// already logged in we authenticate the user.
class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    int uid = _auth.getUID();

    return uid == 0 ? Authenticate() : BottomNavBar();
  }
}
