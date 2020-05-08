import 'package:flutter/material.dart';
import 'package:mybook/models/user.dart';
import 'package:mybook/services/auth_service.dart';
import 'package:mybook/widgets/bottom_nav_bar.dart';
import 'package:mybook/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// Allows the user to create an account
class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _personalInfoFormKey = GlobalKey<FormState>();
  final _profileInfoFormKey = GlobalKey<FormState>();
  bool loading = false;
  dynamic user; // Returned from http request

  // Text field states
  String firstName = '';
  String lastName = '';
  String email = '';
  String dob = '';
  String username = '';
  String password = '';
  String rePassword = '';
  String error = '';

  DateTime value = DateTime.now();
  final format = new DateFormat.yMMMd();

  @override
  Widget build(BuildContext context) {
    // TODO Delete
    print(
        'loading - $loading\tuser - $user\tloading && user != null - ${loading && user != null}');

    if (loading && user != null) {
      return BottomNavBar();
    } else if (loading) {
      return Loading();
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              // Icon
              Center(
                child: Image(
                  image: AssetImage('assets/images/icon.png'),
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
              ),
              SizedBox(height: 10.0),
              // Title
              Center(
                child: Text(
                  'Create an account',
                  style: TextStyle(
                      fontFamily: 'Merriweather',
                      fontSize: 25.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              // Error message
              Visibility(
                visible: error != '',
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    error,
                    style: TextStyle(
                      color: Colors.blueGrey[900],
                      fontSize: 14.0,
                      fontFamily: 'Merriweather',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              // Subtitle
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  'Personal Information',
                  style: TextStyle(
                      fontFamily: 'Merriweather',
                      fontSize: 18.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 10.0),
              // Personal Information form
              // TODO Add more validation to form
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Form(
                  key: _personalInfoFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // First name
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'First Name'),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Please enter a first name.';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() => firstName = val);
                          },
                        ),
                        SizedBox(height: 10.0),
                        // Last name
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Last Name'),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Please enter a last name.';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() => lastName = val);
                          },
                        ),
                        SizedBox(height: 10.0),
                        // Date of birth
                        DateTimeField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Date of birth'),
                          format: format,
                          onShowPicker: (context, currentValue) async {
                            return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime.now(),
                            );
                          },
                          onChanged: (date) => setState(() {
                            value = date;
                            dob = date.toString().substring(0, 10);
                          }),
                          validator: (val) {
                            if (val == null) {
                              return 'Please enter a date of birth';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        // Email
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Please enter an email.';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              // Subtitle
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  'Profile Information',
                  style: TextStyle(
                      fontFamily: 'Merriweather',
                      fontSize: 18.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 10.0),
              // Profile Information form
              // TODO Add more validation to form
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Form(
                  key: _profileInfoFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // Username
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Username'),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Please enter a username.';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() => username = val);
                          },
                        ),
                        SizedBox(height: 10.0),
                        // Password
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Please enter a password.';
                            }
                            return null;
                          },
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height: 10.0),
                        // Re-enter password
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Re-enter password'),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Please re-enter your password.';
                            }

                            if (val != password) {
                              return 'Passwords do not match.';
                            }

                            return null;
                          },
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => rePassword = val);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              // Register button
              FractionallySizedBox(
                widthFactor: 0.30,
                child: RaisedButton(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontFamily: 'Merriweather',
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blueGrey[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () async {
                    if (_personalInfoFormKey.currentState.validate() &&
                        _profileInfoFormKey.currentState.validate()) {
                      setState(() => loading = true);

                      // TODO Delete
                      print('\nIn Register');
                      print(username);
                      print(password);

                      dynamic result = await _auth.register(
                          username, email, password, firstName, lastName, dob);

                      setState(() {
                        if (result == null) {
                          error = 'Could not register with those credentials.';
                          loading = false;
                        } else if (result.runtimeType == String) {
                          error = result;
                          loading = false;
                        } else {
                          user = result as User;

                          print(
                              '\nUSER WAS VALID\t\tuser == null - ${user == null}\nuser - $user\n\n'); // TODO Delete
                        }
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              // Toggle sign in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontFamily: 'Merriweather',
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        fontFamily: 'Merriweather',
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      widget.toggleView();
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      );
    }
  }
}

InputDecoration textInputDecoration = InputDecoration(
  hintStyle: TextStyle(fontFamily: 'Merriweather', fontSize: 14.0),
  fillColor: Colors.white,
  filled: true,
  errorStyle: TextStyle(
      fontFamily: 'Merriweather', fontSize: 13.0, color: Colors.white),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey[100], width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey[900], width: 2.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
);
