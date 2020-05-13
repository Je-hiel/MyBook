import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:mybook/main.dart';
import 'package:mybook/constants.dart';
import 'package:mybook/models/user.dart';

// Responsible for authentication of the user.
// When a user is signed in or registered their user id is saved to the device,
// when they restart the app their user id is read from the device and used
// throughout the application.
class AuthService {
  // Saves the user id of the current user to disk.
  void _setUID(int uid) {
    sp.setInt('user_id', uid);
  }

  // Gets the user id of the current user from disk.
  int getUID() {
    int uid = sp.getInt('user_id') ?? 0;
    return uid;
  }

  // Removes the user id of the current user from disk.
  void _removeUID() {
    if (sp.containsKey('user_id')) {
      sp.remove('user_id');
    }
  }

  // Sign in with username and password.
  Future signIn(String username, String password) async {
    // We have to encode the user input to be used in the request calls.
    final String uid = Uri.encodeQueryComponent(username);
    final String pass = Uri.encodeQueryComponent(password);

    // Full URL of request.
    // final String requestURL = baseURL + signInPath + '?username=$uid&password=$pass';
    final String requestURL =
        testBaseURL + signInPath + '?username=$uid&password=$pass';

    _setUID(0);

    try {
      // Response from request.
      final response = await post(requestURL);

      // If we made the request successfully.
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse == false) {
          // No user was found with the given credentials.
          return null;
        } else {
          // User found.
          User user = User.fromJson(jsonResponse);

          // Save the user id of the signed in user to disk.
          _setUID(user.uid);

          return user;
        }
      } else {
        return 'We had trouble connecting. Please try again later.';
      }
    } catch (e) {
      return 'Something went wrong. Please try again later.';
    }
  }

  // Registers user.
  Future register(String username, String email, String password,
      String firstName, String lastName, String dob) async {
    // We have to encode the user input to be used in the request calls.
    // We do not need to encode dob.
    final String uName = Uri.encodeQueryComponent(username);
    final String uEmail = Uri.encodeQueryComponent(email);
    final String uPassword = Uri.encodeQueryComponent(password);
    final String uFName = Uri.encodeQueryComponent(firstName);
    final String uLName = Uri.encodeQueryComponent(lastName);

    // Full URL of request.
    // final String requestURL = baseURL + registerPath + '?username=$uName&email=$uEmail&password=$uPassword&first_name=$uFName&last_name=$uLName&date_of_birth=$dob';
    final String requestURL = testBaseURL +
        registerPath +
        '?username=$uName&email=$uEmail&password=$uPassword&first_name=$uFName&last_name=$uLName&date_of_birth=$dob';

    _setUID(0);
    print('\n$requestURL\n');
    try {
      // Response from request.
      final response = await post(requestURL);

      // If we made the request successfully.
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse.runtimeType == String) {
          // Username or email already in use.
          String errorMsg = jsonResponse;
          return errorMsg;
        } else {
          // User registered.
          User user = User.fromJson(jsonResponse);

          // Save the user id of the registered user to disk.
          _setUID(user.uid);

          return user;
        }
      } else {
        return 'We had trouble connecting. Please try again later.';
      }
    } catch (e) {
      return 'Something went wrong. Please try again later.';
    }
  }

  // Logs out the user
  void logout() {
    // Removes the user id of the current user from disk.
    _removeUID();
  }
}
