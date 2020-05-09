import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey =
        Provider.of<GlobalKey<ScaffoldState>>(context);

    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: false,
      // User profile photo
      leading: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            // TODO Replace with user profile photo.
            backgroundImage: AssetImage('assets/images/jehiel.jpg'),
          ),
        ),
        onTap: () => scaffoldKey.currentState.openDrawer(),
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
