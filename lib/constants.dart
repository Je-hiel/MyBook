import 'package:flutter/material.dart';
import 'package:mybook/screens/groups.dart';
import 'package:mybook/screens/home.dart';
import 'package:mybook/screens/messages.dart';
import 'package:mybook/screens/search.dart';

/// **************   HTTPSERVICE RELATED CONSTANTS   **************** ///
final String baseURL = 'http://mybook-3161.000webhostapp.com';
final String testBaseURL = 'http://10.0.2.2/mybook_test';
final String registerPath = '/register.php';
final String signInPath = '/sign_in.php';
final String getUserPath = '/get_user.php';
final String addPostPath = '/add_post.php';
final String getPostsPath = '/get_posts.php';
final String addCommentPath = '/add_comment.php';
final String getCommentsPath = '/get_comments.php';
final String joinGroupPath = '/join_group.php';
final String getGroupMembersPath = '/get_group_members.php';
final String addContentEditorPath = '/add_content_editor.php';
final String getGroupContentEditorsPath = '/get_group_content_editors.php';
final String addFriendPath = '/add_friend.php';
final String getUserFriendsPath = '/get_user_friends.php';
final String addGroupPath = '/add_group.php';
final String getUserGroupsPath = '/get_user_groups.php';
final String addGroupPostPath = '/add_group_post.php';
final String getGroupPostsPath = '/get_group_posts.php';
final String addPostPhotoPath = '/add_post_photo.php';
final String getPostPostPath = '/get_post_post.php';
final String getCommentCountPath = '/get_comment_count.php';
final String getLikesCountPath = '/get_likes_count.php';
final String getDislikesCountPath = '/get_dislikes_count.php';
final String likePostPath = '/like_post.php';
final String dislikePostPath = '/dislike_post.php';
final String likedPostPath = '/get_user_liked.php';
final String dislikedPostPath = '/get_user_disliked.php';
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
  fontWeight: FontWeight.w600,
  fontSize: 15.0,
);

const bodyStyle = TextStyle(
  fontSize: 14.0,
);
