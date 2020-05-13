import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mybook/models/group.dart';

class GroupHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Group group = Provider.of<Group>(context);

    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/default group.png'),
          radius: 20.0,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 3.0),
            Text(
              'Something',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        ),
        Spacer(),
        Text('Member Count'),
      ],
    );
  }
}
