import 'package:flutter/material.dart';
import 'package:mybook/constants.dart';
import 'package:mybook/widgets/main_app_bar.dart';
import 'package:mybook/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey =
        Provider.of<GlobalKey<ScaffoldState>>(context);

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              // TODO Replace with user profile photo.
              backgroundImage: AssetImage(
                  'assets/images/jehiel.jpg'), //NetworkImage(user.profilePhoto),
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
      ),
      body: Center(
        child: Text(
          'Still under development...',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
