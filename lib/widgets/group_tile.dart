import 'package:flutter/material.dart';
import 'package:mybook/models/group.dart';
import 'package:provider/provider.dart';
import 'package:mybook/widgets/group_header.dart';
import 'package:mybook/widgets/group_action_row.dart';
import 'group_detail.dart';

class GroupTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Group group = Provider.of<Group>(context);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Provider<Group>(
            create: (_) => group,
            child: GroupDetail(),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GroupHeader(),
              SizedBox(height: 11.0),
              GroupActionRow(),
            ],
          ),
        ),
      ),
    );
  }
}
