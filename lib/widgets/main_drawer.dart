import 'package:flutter/material.dart';

// TODO Make sure drawer covers bottomNavBar when open
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // TODO Make DrawerHeader bigger.
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  // TODO Replace with user profile photo.
                  backgroundImage: AssetImage('assets/images/jehiel.jpg'),
                  radius: 30.0,
                ),
                SizedBox(height: 10.0),
                // TODO Replace with user display name.
                Text('Je-hiel Smith'),
                SizedBox(height: 2.0),
                // TODO Replace with user username.
                Text('@jehielsmith'),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    // TODO Replace with user friend count.
                    Text('168 Friends'),
                    SizedBox(width: 15.0),
                    // TODO Replace with user group count.
                    Text('37 Groups'),
                  ],
                ),
              ],
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
        ],
      ),
    );
  }
}
