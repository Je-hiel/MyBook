import 'package:flutter/material.dart';
import 'package:mybook/constants.dart';
import 'package:mybook/models/post.dart';
import 'package:mybook/screens/post_detail.dart';
import 'package:mybook/widgets/post/post_header.dart';
import 'package:mybook/widgets/post/post_photos.dart';

class PostTile extends StatefulWidget {
  final Post post;

  PostTile({this.post});

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    Post post = widget.post;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PostDetail(
            post: widget.post,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PostHeader(
                post: post,
              ),
              SizedBox(height: 8.0),
              // Post title
              Text(
                post.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: titleStyle.copyWith(fontSize: 17.0),
              ),
              SizedBox(height: 5.0),
              // Post text
              Text(
                post.body,
                overflow: TextOverflow.fade,
                maxLines: 7,
              ),
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
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PostDetail(
                              post: widget.post,
                            ),
                          ),
                        ),
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
      ),
    );
  }
}
