import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:mybook/constants.dart';
import 'package:mybook/models/user.dart';

// Class for handling miscellaneous http requests
class HttpService {
  // TODO Need to fix http request to be like signIn and register
  Future<User> getUser(int uid) async {
    final response = await post(baseURL + getUserPath, body: {
      "user_id": uid,
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse == null) {
        // No user was found with the given user id
        return null;
      } else {
        // User found
        return User.fromJson(jsonResponse);
      }
    } else {
      // Could not connect to server
      throw Exception('Failed to sign in.');
    }
  }
}
