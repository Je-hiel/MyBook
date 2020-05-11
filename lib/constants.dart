import 'package:flutter/material.dart';
import 'package:mybook/screens/groups.dart';
import 'package:mybook/screens/home.dart';
import 'package:mybook/screens/messages.dart';
import 'package:mybook/screens/search.dart';

/// **************   HTTPSERVICE RELATED CONSTANTS   **************** ///
final String baseURL = 'http://mybook-3161.000webhostapp.com';
final String testBaseURL = 'http://10.0.2.2/mybook_test';
final String baseURI = '10.0.2.2';
final String registerPath = '/register.php';
final String signInPath = '/sign_in.php';
final String getUserPath = '/get_user.php';
final String addPostPath = '/add_post.php';
final String getPostsPath = '/get_posts.php';
final headers = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8'
};

/// **************   AUTHENTICATION FORM RELATED CONSTANTS   **************** ///
final enabledBorderColor = Colors.blueGrey.shade100;

/// **************   BOTTOM NAVIGATION BAR RELATED CONSTANTS   **************** ///
enum Page {
  HOME,
  GROUPS,
  SEARCH,
  MESSAGES,
}

final List<Widget> bottomNavBarPages = [
  Home(
    key: PageStorageKey('Home'),
  ),
  Groups(
    key: PageStorageKey('Groups'),
  ),
  Search(
    key: PageStorageKey('Search'),
  ),
  Messages(
    key: PageStorageKey('Messages'),
  ),
];

final PageStorageBucket bucket = PageStorageBucket();

final List<BottomNavigationBarItem> bottomNavBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    title: Text('Home'),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.people),
    title: Text('Groups'),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.search),
    title: Text('Search'),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.email),
    title: Text('Messages'),
  ),
];

final ScrollController homeController = ScrollController();
final ScrollController groupsController = ScrollController();
final ScrollController searchController = ScrollController();
final ScrollController messagesController = ScrollController();

/// **************   POST RELATED CONSTANTS   **************** ///
const titleStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 23.0,
);
