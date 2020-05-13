import 'package:flutter/material.dart';
import 'package:mybook/models/post.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostHeader extends StatelessWidget {
  final bool timeDetail;

  PostHeader({this.timeDetail});

  @override
  Widget build(BuildContext context) {
    Post post = Provider.of<Post>(context);
    final String date = DateFormat('HH:mm • d MMM yy').format(
        DateTime.parse('${post.createdAt}').subtract(Duration(hours: 5)));

    return Row(
      children: <Widget>[
        // TODO Replace with user profile photo.
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/default user.png'),
          radius: 20.0,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${post.firstName} ${post.lastName}',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 3.0),
            Text(
              '@${post.username}',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        ),
        Spacer(),
        timeDetail
            ? Text(date)
            : Text(
                timeago.format(
                  DateTime.parse('${post.createdAt}').subtract(
                    Duration(hours: 5), // Hard-coded timezone. Not good.
                  ),
                ),
              ),
      ],
    );
  }
}
