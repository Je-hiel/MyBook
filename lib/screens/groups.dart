import 'package:flutter/material.dart';
import 'package:mybook/constants.dart';
import 'package:mybook/widgets/main_app_bar.dart';
import 'package:mybook/widgets/main_drawer.dart';

class Groups extends StatelessWidget {
  const Groups({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: CustomScrollView(
        controller: groupsController, // Used to return to top of list.
        slivers: <Widget>[
          // AppBar that hides as the user scrolls down and reappears
          // when the user scrolls up.
          MainAppBar(),
          SliverList(
            // TODO Build list of group posts.
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Groups'),
                  trailing: Text('$index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
