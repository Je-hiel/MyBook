import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mybook/constants.dart';
import 'package:mybook/models/user.dart';

// Responsible for authentication of the user.
// When a user is signed in or registered their user id is saved to the device,
// when they restart the app their user id is read from the device and used
// throughout the application.
class AuthService {
  // Saves the user id of the current user to disk
  void _setUID(int uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('user_id', uid);
  }

  // Gets the user id of the current user from disk
  static Future<int> getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int uid = prefs.getInt('user_id') ?? 0;

    // TODO Delete
    print('\nINSIDE getUID');
    print('current uid - $uid');

    return Future.value(uid);
  }

  // Removes the user id of the current user from disk
  void _removeUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('user_id')) {
      prefs.remove('user_id');
    }
  }

  // Sign in with username and password
  Future<User> signIn(String username, String password) async {
    final String requestURL =
        baseURL + signInPath + '?username=$username&password=$password';
    final response = await post(requestURL);

    // TODO Delete
    print('AUTH SERVICE\t\tIn sign in');
    print(response.statusCode);
    print(requestURL);

    _setUID(0);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse == null) {
        // No user was found with the given credentials
        return null;
      } else {
        // User found
        User user = User.fromJson(jsonResponse);
        _setUID(user.uid); // Save the user id of the signed in user to disk

        print(user.uid); // TODO Delete

        return user;
      }
    } else {
      // Could not connect to server
      throw Exception('Failed to sign in.');
    }
  }

  // Registers user
  Future register(String username, String email, String password,
      String firstName, String lastName, String dob) async {
    final String requestURL = baseURL +
        registerPath +
        '?username=$username&email=$email&password=$password&first_name=$firstName&last_name=$lastName&date_of_birth=$dob';
    final response = await post(requestURL);

    _setUID(0);

    // TODO Delete
    print('AUTH SERVICE\t\tIn register');
    print(response.statusCode);
    print(requestURL);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse.runtimeType == String) {
        // Username or email already in use.
        String errorMsg = jsonResponse;

        print(errorMsg); // TODO Delete
        return errorMsg;
        //return null;
      } else {
        print(jsonResponse); // TODO Delete

        // User registered
        User user = User.fromJson(jsonResponse);

        _setUID(user.uid); // Save the user id of the registered user to disk
        print(user.uid); // TODO Delete

        return User.fromJson(jsonResponse);
      }
    } else {
      // Could not connect to server
      throw Exception('Failed to register user.');
    }
  }

  void logout() {
    _removeUID();
  }
}
