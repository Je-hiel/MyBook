import 'package:flutter/material.dart';
import 'package:mybook/constants.dart';
import 'package:mybook/models/post.dart';
import 'package:mybook/services/auth_service.dart';
import 'package:mybook/widgets/main_app_bar.dart';
import 'package:mybook/widgets/main_drawer.dart';
import 'package:mybook/widgets/post/post_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();

    return Scaffold(
      drawer: MainDrawer(),
      body: CustomScrollView(
        controller: homeController,
        slivers: <Widget>[
          // AppBar that hides as the user scrolls down and reappears
          // when the user scrolls up.
          MainAppBar(),
          SliverList(
            /* TODO Make this build a list of user and group posts.
                Will we need a group post model? What will store combination of
                user and group posts? Group posts are just posts from people
                you're in groups with*/
            // Builds list of posts.
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return PostTile(post: posts[index % 5]);
              },
            ),
          ),
        ],
      ),

      /// LOGOUT functionality has not been built yet. Press this button to clear the user id and hot restart the app to logout
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_comment),
        onPressed: () async {
          print('Removing uid...');
          auth.logout();
        },
      ),
    );
  }
}
