import 'package:flutter/material.dart';
import 'package:mybook/constants.dart';
import 'package:mybook/widgets/main_app_bar.dart';
import 'package:mybook/widgets/main_drawer.dart';

class Search extends StatelessWidget {
  const Search({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: CustomScrollView(
        controller: searchController,
        slivers: <Widget>[
          // AppBar that hides as the user scrolls down and reappears
          // when the user scrolls up.
          MainAppBar(),
          SliverList(
            // TODO Build user search.
            // TODO Build user card widgets for results.
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Search'),
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
