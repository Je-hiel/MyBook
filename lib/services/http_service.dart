import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:mybook/constants.dart';
import 'package:mybook/models/post.dart';
import 'package:mybook/models/user.dart';

// Class for handling http requests.
class HttpService {
  // Returns a user.
  Future getUser(int uid) async {
    // Full URL of request.
    final String requestURL = baseURL + getUserPath + '?user_id=$uid';

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
        return 'We had trouble connecting. Please try again later.';
      }
    } catch (e) {
      return 'Something went wrong. Please try again later.\n$e';
    }
  }

  // Adds a post.
  Future addPost(int uid, String title, String body) async {
    // We have to encode the user input to be used in the request calls.
    final String uTitle = Uri.encodeQueryComponent(title);
    final String uBody = Uri.encodeQueryComponent(body);

    // Full URL of request.
    final String requestURL =
        baseURL + addPostPath + '?user_id=$uid&title=$uTitle&body=$uBody';

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
        return 'We had trouble connecting. Please try again later.';
      }
    } catch (e) {
      return 'Something went wrong. Please try again later.';
    }
  }

  // Gets posts from user and their friends.
  Future<List<Post>> getPosts(int uid) async {
    // Full URL of request.
    final String requestURL = baseURL + getPostsPath + '?user_id=$uid';

    List<Post> result = [];

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
          PostList postList = PostList.fromJson(jsonResponse);
          return postList.posts;
        }
      } else {
        print('We had trouble connecting. Please try again later.');
        return result;
      }
    } catch (e) {
      print('Something went wrong. Please try again later.');
      return result;
    }
  }

  // Gets posts from groups the user is in.
  Future getGroupPosts(int uid) async {}

  // Gets the friends of the user.
  Future getFriends(int uid) async {}
}
