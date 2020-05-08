import 'package:flutter/material.dart';
import 'package:mybook/constants.dart';
import 'package:mybook/widgets/main_app_bar.dart';
import 'package:mybook/widgets/main_drawer.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: CustomScrollView(
        controller: messagesController,
        slivers: <Widget>[
          // AppBar that hides as the user scrolls down and reappears
          // when the user scrolls up.
          MainAppBar(),
          SliverList(
            // TODO Build fake messages (or real messages)
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Messages'),
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
