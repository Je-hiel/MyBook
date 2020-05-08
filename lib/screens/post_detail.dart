import 'package:flutter/material.dart';
import 'package:mybook/constants.dart';
import 'package:mybook/models/post.dart';
import 'package:mybook/widgets/post/post_header.dart';
import 'package:mybook/widgets/post/post_photos.dart';

// WHY IS THIS STATEFUL?
class PostDetail extends StatefulWidget {
  final Post post;

  PostDetail({this.post});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    Post post = widget.post;

    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // TODO Would have to pass in user who made the post.
              PostHeader(),
              SizedBox(height: 20),
              // TODO Add Hero widget between PostTile and PostDetail.
              // TODO Build PostContent widget.
              //PostContent(post: widget.post),
              // TODO Create post specific text styling.
              Text(
                post.title,
                style: titleStyle,
              ),
              SizedBox(height: 10),
              // Post text
              Text(post.text),
              SizedBox(height: 10.0),
              // Post images (if any)
              Visibility(
                visible: post.hasImages(),
                child: PostPhotos(imageURLs: post.images),
              ),
              // Post buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // TODO Make buttons change colour and keep count when pressed.
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        iconSize: 20.0,
                        onPressed: () {
                          setState(post.likePost);
                        },
                        color: post.liked ? Colors.green : Colors.grey,
                      ),
                      Text('${post.likesCount}'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.thumb_down),
                        iconSize: 20.0,
                        onPressed: () {
                          setState(post.dislikePost);
                        },
                        color: post.disliked ? Colors.red : Colors.grey,
                      ),
                      Text('${post.dislikesCount}'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.comment),
                        iconSize: 20.0,
                        onPressed: () {},
                        color: post.commented ? Colors.blue : Colors.grey,
                      ),
                      Text('${post.comments.length}'),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    iconSize: 20.0,
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
