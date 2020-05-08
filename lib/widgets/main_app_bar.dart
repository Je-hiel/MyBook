import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: false,
      // User profile photo
      // TODO Add functionality to pull out drawer when profile photo is tapped.
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          // TODO Replace with user profile photo.
          backgroundImage: AssetImage('assets/images/jehiel.jpg'),
        ),
      ),
      centerTitle: true,
      // TODO Add onTap to take user back to home.
      title: Tab(
        icon: Image.asset(
          'assets/images/icon.png',
          color: Colors.white,
        ),
      ),
      actions: <Widget>[
        // TODO Add alerts to notification. Can also add dropdown.
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
      ],
    );
  }
}
