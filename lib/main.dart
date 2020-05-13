import 'package:flutter/material.dart';
import 'package:mybook/screens/authenticate/authenticate.dart';
import 'package:mybook/screens/wrapper.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This shared preference is used to save the user's id to their device to keep them logged in.
SharedPreferences sp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Prevents the user from rotating their device.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyBook',
      theme: ThemeData(
        // TODO Specify more colors here.
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Merriweather',
      ),
      routes: <String, WidgetBuilder>{
        '/Authenticate': (BuildContext context) => new Authenticate()
      },
      home:
          Wrapper(), // The wrapper widget determines if we authenticate the user or take them straight to the home screen.
    );
  }
}
