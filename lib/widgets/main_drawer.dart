import 'package:flutter/material.dart';
import 'package:mybook/models/user.dart';
import 'package:mybook/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    AuthService _auth = AuthService();

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName:
                Text('${user.firstName} ${user.lastName}'), // TODO Add styling.
            accountEmail: Text('@${user.username}'),
            currentAccountPicture: CircleAvatar(
              // TODO Replace with user profile photo.
              backgroundImage: AssetImage('assets/images/jehiel.jpg'),
              radius: 30.0,
            ),
          ),
          // TODO Provide navigation to other screens.
          // TODO Move icons closer to title.
          // TODO Make tiles clickable.
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Transform.rotate(
              child: Icon(Icons.exit_to_app),
              angle: 180 * math.pi / 180,
            ),
            title: Text('Logout'),
            onTap: () {
              _auth.logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/Authenticate', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
