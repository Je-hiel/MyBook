import 'package:flutter/material.dart';
import 'package:mybook/models/post.dart';

class PostHeader extends StatelessWidget {
  final Post post;

  PostHeader({this.post});

  // How do we update user profile photo in post header?
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // TODO Replace with user profile photo.
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/jehiel.jpg'),
          radius: 20.0,
        ),
        SizedBox(width: 10),
        Column(
          children: <Widget>[
            // TODO Replace with user display name.
            Text('Je-hiel Smith'),
            SizedBox(height: 3.0),
            // TODO Replace with user username.
            Text('@jehielsmith'),
          ],
        ),
        Spacer(),
        // TODO Replace with post created_at value.
        Text('4hrs'),
      ],
    );
  }
}
