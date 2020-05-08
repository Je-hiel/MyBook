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
  var _currentUID; // User ID of currently logged in user.

  // This async function has to execute first so that we can get the uid.
  setCurrentUID() async {
    _currentUID = await AuthService.getUID();
  }

  // We call the async function from this method so that the _currentUID has a value
  // before we reach the build method.
  @override
  void initState() {
    setCurrentUID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'INSIDE WRAPPER\n_currentUID = $_currentUID\t\t_currentUID == 0 || _currentUID == null - ${_currentUID == 0 || _currentUID == null}'); // TODO Delete
    return _currentUID == 0 || _currentUID == null
        ? Authenticate()
        : BottomNavBar();
  }
}
