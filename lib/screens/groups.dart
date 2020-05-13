import 'package:flutter/material.dart';
import 'package:mybook/constants.dart';
import 'package:mybook/models/group.dart';
import 'package:mybook/widgets/group_tile.dart';
import 'package:mybook/widgets/main_app_bar.dart';
import 'package:mybook/widgets/main_drawer.dart';
import 'package:async/async.dart';
import 'package:mybook/services/auth_service.dart';
import 'package:mybook/services/http_service.dart';

class Groups extends StatefulWidget {
  Groups({Key key}) : super(key: key);

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final _groupsCache = new AsyncCache<List<Group>>(Duration(minutes: 5));
  final _userGroupsCache = new AsyncCache<List<Group>>(Duration(
      minutes: 5)); // Cache the posts and refresh the cache every 5 minutes.
  HttpService _hs = HttpService();
  AuthService _auth = AuthService();

  Future<List<Group>> getAllPostsInCache() {
    return _groupsCache.fetch(() {
      return _hs.getGroups();
    });
  }

  Future<List<Group>> getUserGroupsInCache() {
    return _userGroupsCache.fetch(() {
      return _hs.getUserGroups(_auth.getUID());
    });
  }

  @override
  void initState() {
    _groupsCache.invalidate();
    _userGroupsCache.invalidate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              MainAppBar(),
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                snap: false,
                floating: true,
                expandedHeight: 0.0,
                elevation: 15,
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(
                      text: 'All Groups',
                    ),
                    Tab(
                      text: 'Your Groups',
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              ListView.builder(
                key: new PageStorageKey('allGroups'),
                itemBuilder: (context, index) {
                  return GroupTile();
                },
              ),
              ListView.builder(
                key: new PageStorageKey('yourGroups'),
                itemBuilder: (context, index) {
                  return Text('Page 2 \t $index');
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.group_add),
        tooltip: 'Create group',
        onPressed: () {},
      ),
    );
  }
}
