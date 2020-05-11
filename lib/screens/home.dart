import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybook/constants.dart';
import 'package:mybook/models/post.dart';
import 'package:mybook/models/user.dart';
import 'package:mybook/services/auth_service.dart';
import 'package:mybook/services/http_service.dart';
import 'package:mybook/widgets/loading.dart';
import 'package:mybook/widgets/main_app_bar.dart';
import 'package:mybook/widgets/post/post_tile.dart';
import 'package:provider/provider.dart';

import 'add_post.dart';

// Allows the user to see their posts and posts from friends.
class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _postsCache = new AsyncCache<List<Post>>(Duration(
      minutes: 5)); // Cache the posts and refresh the cache every 5 minutes.
  HttpService _hs = HttpService();
  AuthService _auth = AuthService();

  Future<List<Post>> getPostsInCache() {
    return _postsCache.fetch(() {
      return _hs.getPosts(_auth.getUID());
    });
  }

  @override
  void initState() {
    _postsCache.invalidate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPostsInCache(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Scaffold(
              body: Loading(),
            );
            break;
          case ConnectionState.done:
            List<Post> posts = snapshot.data;
            GlobalKey<ScaffoldState> scaffoldKey =
                Provider.of<GlobalKey<ScaffoldState>>(context);

            if (posts.isEmpty) {
              //User user = Provider.of<User>(context);
              return Scaffold(
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
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'No posts yet!\n\nAdd some friends or create your own posts.',
                      style:
                          TextStyle(fontSize: 16.0, fontFamily: 'Merriweather'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.create),
                  onPressed: () {
                    _postsCache.invalidate();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Provider<User>(
                          create: (_) => Provider.of<User>(context),
                          child: AddPost(),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Scaffold(
                body: RefreshIndicator(
                  child: CustomScrollView(
                    controller: homeController,
                    slivers: <Widget>[
                      // AppBar that hides as the user scrolls down and reappears
                      // when the user scrolls up.
                      MainAppBar(),
                      SliverList(
                        // Builds list of posts.
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return PostTile(post: posts[index]);
                          },
                          childCount: posts.length,
                        ),
                      ),
                    ],
                  ),
                  onRefresh: () {
                    setState(() {
                      _postsCache.invalidate();
                    });
                    return Future.value(1);
                  },
                  displacement: 80.0,
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.create),
                  onPressed: () {
                    _postsCache.invalidate();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Provider<User>(
                          create: (_) => Provider.of<User>(context),
                          child: AddPost(),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            break;
          default:
            return Scaffold(
              body: Loading(),
            );
            break;
        }
      },
    );
  }
}
