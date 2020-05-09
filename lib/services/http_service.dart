import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:mybook/constants.dart';
import 'package:mybook/models/user.dart';

// Class for handling miscellaneous http requests
class HttpService {
  // TODO Need to fix http request to be like signIn and register
  Future<User> getUser(int uid) async {
    final String requestURL = baseURL + getUserPath + '?user_id=$uid';
    final response = await post(requestURL);

    // TODO Delete
    print('HTTP SERVICE\t\tIn getUser');
    print(response.statusCode);
    print(requestURL);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse == null) {
        // User was not returned for some reason.
        return null;
      } else {
        // User found
        User user = User.fromJson(jsonResponse);
        print(user.uid); // TODO Delete

        return user;
      }
    } else {
      // Could not connect to server
      throw Exception('Failed to get user details.');
    }
  }
}
