import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:mybook/constants.dart';
import 'package:mybook/models/post.dart';
import 'package:mybook/models/user.dart';
import 'package:mybook/models/comment.dart';

// Class for handling http requests.
class HttpService {
  // Returns a user.
  Future getUser(int uid) async {
    // Full URL of request.
    // final String requestURL = baseURL + getUserPath + '?user_id=$uid';
    final String requestURL = testBaseURL + getUserPath + '?user_id=$uid';

    print(
        '\n\n$requestURL\n---------------------\nInside getUser\n---------------------\n');

    try {
      // Response from request.
      final response = await post(requestURL);

      // If we made the request successfully.
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse == null) {
          // User was not returned.
          return null;
        } else {
          // User found.
          User user = User.fromJson(jsonResponse);
          return user;
        }
      } else {
        print('getUser\nWe had trouble connecting. Please try again later.');
        return 'We had trouble connecting. Please try again later.';
      }
    } catch (e) {
      print('getUser\nSomething went wrong. Please try again later.\n$e');
      return 'Something went wrong. Please try again later.';
    }
  }

  // Adds a post.
  Future addPost(int uid, String title, String body) async {
    // We have to encode the user input to be used in the request calls.
    final String pTitle = Uri.encodeQueryComponent(title);
    final String pBody = Uri.encodeQueryComponent(body);

    // Full URL of request.
    // final String requestURL = baseURL + addPostPath + '?user_id=$uid&title=$pTitle&body=$pBody';
    final String requestURL =
        testBaseURL + addPostPath + '?user_id=$uid&title=$pTitle&body=$pBody';

    print(
        '\n\n$requestURL\n---------------------\nInside addPost\n---------------------\n');

    try {
      // Response from request.
      final response = await post(requestURL);

      // If we made the request successfully.
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse.runtimeType == String) {
          // Post was not added
          return jsonResponse;
        } else {
          // Post added
          return true;
        }
      } else {
        print('addPost\nWe had trouble connecting. Please try again later.');
        return 'We had trouble connecting. Please try again later.';
      }
    } catch (e) {
      print('addPost\nSomething went wrong. Please try again later.\n$e');
      return 'Something went wrong. Please try again later.';
    }
  }

  // Gets posts from user and their friends.
  Future<List<Post>> getPosts(int uid) async {
    // Full URL of request.
    // final String requestURL = baseURL + getPostsPath + '?user_id=$uid';
    final String requestURL = testBaseURL + getPostsPath + '?user_id=$uid';
    List<Post> result = [];

    print(
        '\n\n$requestURL\n---------------------\nInside getPosts\n---------------------\n');

    try {
      // Response from request.
      final response = await post(requestURL);

      // If we made the request successfully.
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse == []) {
          // No posts.
          return result;
        } else {
          // Posts available.
          PostList postList = PostList().postListFromJson(jsonResponse);
          return postList.posts;
        }
      } else {
        print('getPost\nWe had trouble connecting. Please try again later.');
        return result;
      }
    } catch (e) {
      print('getPost\nSomething went wrong. Please try again later.\n$e');
      return result;
    }
  }

  // Adds post to a group the user is in.
  Future addGroupPost(int uid, int gid, String title, String body) async {}

  // Gets posts from all groups the user is in.
  Future getGroupPosts(int uid, int gid) async {
    // Full URL of request.
    // final String requestURL = baseURL + Path + '?user_id=$uid&group_id=$gid';
    final String requestURL =
        testBaseURL + getGroupPostsPath + '?user_id=$uid&group_id=$gid';

    print(
        '\n\n$requestURL\n---------------------\nInside getGroupPosts\n---------------------\n');

    try {
      // Response from request.
      final response = await post(requestURL);

      // If we made the request successfully.
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse == []) {
          // No group posts available.
          return jsonResponse;
        } else {
          // Posts available
          return true;
        }
      } else {
        print(
            'getGroupPosts\nWe had trouble connecting. Please try again later.');
        return 'We had trouble connecting. Please try again later.';
      }
    } catch (e) {
      print('getGroupPosts\nSomething went wrong. Please try again later.\n$e');
      return 'Something went wrong. Please try again later.';
    }
  }

  Future getGroups() async {}

  Future getUserGroups(int uid) async {}

  // TODO Set up friend request system.
  // Adds another user as a friend.
  Future addFriend(int uid, int fid, String type) async {}

  // Gets the friends of the user.
  Future getFriends(int uid) async {}

  // Adds a comment to a post.
  Future addComment(int uid, int pid, String body) async {
    // We have to encode the user input to be used in the request calls.
    final String cBody = Uri.encodeQueryComponent(body);

    // Full URL of request.
    // final String requestURL = baseURL + addCommentPath + '?user_id=$uid&post_id=$pid&body=$cBody';
    final String requestURL =
        testBaseURL + addCommentPath + '?user_id=$uid&post_id=$pid&body=$cBody';

    print(
        '\n\n$requestURL\n---------------------\nInside addComment\n---------------------\n');

    try {
      // Response from request.
      final response = await post(requestURL);

      // If we made the request successfully.
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse.runtimeType == String) {
          // Comment was not added.
          return jsonResponse;
        } else {
          // Comment added.
          return true;
        }
      } else {
        print('addComment\nWe had trouble connecting. Please try again later.');
        return 'We had trouble connecting. Please try again later.';
      }
    } catch (e) {
      print('addComment\nSomething went wrong. Please try again later.\n$e');
      return 'Something went wrong. Please try again later.';
    }
  }

  // Gets all comments on a post.
  Future<List<Comment>> getComments(int pid) async {
    // Full URL of request.
    // final String requestURL = baseURL + getCommentsPath + '?post_id=$pid';
    final String requestURL = testBaseURL + getCommentsPath + '?post_id=$pid';

    List<Comment> result = [];

    print(
        '\n\n$requestURL\n---------------------\nInside getComments\n---------------------\n');

    try {
      // Response from request.
      final response = await post(requestURL);

      // If we made the request successfully.
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse == []) {
          // No comments.
          return result;
        } else {
          // Comments available.
          CommentList commentList = CommentList.fromJson(jsonResponse);
          return commentList.comments;
        }
      } else {
        print(
            'getComments\nWe had trouble connecting. Please try again later.');
        return result;
      }
    } catch (e) {
      print('getComments\nSomething went wrong. Please try again later.\n$e');
      return result;
    }
  }

  // Gets the number of comments on a post
  Future<int> getCommentCount(int pid) async {
    // Full URL of request.
    // final String requestURL = baseURL + getCommentCountPath + '?post_id=$pid';
    final String requestURL =
        testBaseURL + getCommentCountPath + '?post_id=$pid';

    int result = 0;

    print(
        '\n\n$requestURL\n---------------------\nInside getCommentCount\n---------------------\n');

    try {
      // Response from request.
      final response = await post(requestURL);

      // If we made the request successfully.
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        result = jsonResponse['count'];

        return result;
      } else {
        print(
            'getCommentCount\nWe had trouble connecting. Please try again later.');
        return result;
      }
    } catch (e) {
      print(
          'getCommentCount\nSomething went wrong. Please try again later.\n$e');
      return result;
    }
  }

  // TODO Implement a search.

/*
  //
  Future template() async {
    // We have to encode the user input to be used in the request calls.
    final String  = Uri.encodeQueryComponent();

    // Full URL of request.
    // final String requestURL = baseURL + Path + '?user_id=$uid&post_id=$pid&body=$cBody';
    final String requestURL = testBaseURL + Path + '?user_id=$uid&post_id=$pid&body=$cBody';

    print('\n\n$requestURL\n---------------------\nInside *name*\n---------------------\n');

    try {
      // Response from request.
      final response = await post(requestURL);

      // If we made the request successfully.
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse.runtimeType == String) {
          //  not .
          return jsonResponse;
        } else {
          //
          return true;
        }
      } else {
        print('*name*\nWe had trouble connecting. Please try again later.');
        return 'We had trouble connecting. Please try again later.';
      }

    } catch (e) {
      print('*name*\nSomething went wrong. Please try again later.\n$e');
      return 'Something went wrong. Please try again later.';
    }
  }
  */
}
