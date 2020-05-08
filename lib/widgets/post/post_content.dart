import 'package:flutter/material.dart';
import 'package:mybook/models/post.dart';

class PostContent extends StatefulWidget {
  Post post;
  bool previewMode;

  PostContent({this.post, this.previewMode = true});

  @override
  _PostContentState createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  @override
  Widget build(BuildContext context) {
    Post post = widget.post;
    if (widget.previewMode) {
      return Container();
    } else {
      return Container();
    }
  }
}
