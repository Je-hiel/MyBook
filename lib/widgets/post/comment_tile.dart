import 'package:flutter/material.dart';
import 'package:mybook/models/comment.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentTile extends StatelessWidget {
  Comment comment;

  CommentTile({this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.black,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${comment.firstName} ${comment.lastName}',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 3.0),
                Text(
                  '@${comment.username}',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Spacer(),
            Text(
              timeago.format(
                DateTime.parse('${comment.createdAt}').subtract(
                  Duration(hours: 5), // Hard-coded timezone. Not good.
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(comment.body),
        Divider(
          thickness: 1.5,
        ),
      ],
    );
  }
}
