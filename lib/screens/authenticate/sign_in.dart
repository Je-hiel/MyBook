import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybook/services/auth_service.dart';
import 'package:mybook/widgets/bottom_nav_bar.dart';
import 'package:mybook/widgets/loading.dart';

// Allows a user to sign in
class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  dynamic user;

  // Text field states
  String username = '';
  String password = '';
  String error = '';

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              // Icon
              Center(
                child: Image(
                  image: AssetImage('assets/images/icon.png'),
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
              ),
              SizedBox(height: 10.0),
              // Title
              Center(
                child: Text(
                  'MyBook',
                  style: TextStyle(
                      fontFamily: 'Satisfy',
                      fontSize: 40.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              // Sign In form
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
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
                        SizedBox(height: 20.0),
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
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              // Error message
              Visibility(
                visible: error != '',
                child: Center(
                  child: Text(
                    error,
                    style: TextStyle(
                      color: Colors.blueGrey[900],
                      fontSize: 14.0,
                      fontFamily: 'Merriweather',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              // Sign in button
              FractionallySizedBox(
                widthFactor: 0.30,
                child: RaisedButton(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontFamily: 'Merriweather',
                    ),
                  ),
                  color: Colors.blueGrey[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);

                      // TODO Delete
                      print('\nIn sign in');
                      print(username);
                      print(password);

                      dynamic result = await _auth.signIn(username, password);

                      setState(() {
                        if (result == null) {
                          error = 'Could not sign in with those credentials.';
                          loading = false;
                        } else {
                          user = result;
                        }
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 10.0),
              // Toggle sign in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      fontFamily: 'Merriweather',
                      //color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      'Register',
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
    borderRadius: BorderRadius.circular(30.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey[900], width: 2.0),
    borderRadius: BorderRadius.circular(30.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
    borderRadius: BorderRadius.circular(30.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
    borderRadius: BorderRadius.circular(30.0),
  ),
);
