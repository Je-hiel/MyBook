import 'package:flutter/material.dart';
import 'package:mybook/screens/wrapper.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyBook',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home:
          Wrapper(), // The wrapper widget determines if we authenticate the user or take them straight to the home screen
    );
  }
}
