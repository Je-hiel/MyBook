import 'package:flutter/material.dart';

class PostLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Posting...',
              style: TextStyle(
                  fontFamily: 'Merriweather', fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20.0,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
