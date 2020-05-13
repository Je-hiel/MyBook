import 'package:flutter/material.dart';
import 'package:mybook/models/post.dart';
import 'package:mybook/screens/post_detail.dart';
import 'package:mybook/widgets/post/interaction_row.dart';
import 'package:mybook/widgets/post/post_content.dart';
import 'package:mybook/widgets/post/post_header.dart';
import 'package:provider/provider.dart';

class PostTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Post post = Provider.of<Post>(context);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Provider<Post>(
            create: (_) => post,
            child: PostDetail(post: post),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PostHeader(timeDetail: false),
              SizedBox(height: 11.0),
              PostContent(preview: true),
              InteractionRow(),
            ],
          ),
        ),
      ),
    );
  }
}
