import 'package:flutter/material.dart';
import 'package:mybook/models/post.dart';
import 'package:mybook/services/http_service.dart';
import 'package:provider/provider.dart';

class InteractionRow extends StatefulWidget {
  @override
  _InteractionRowState createState() => _InteractionRowState();
}

class _InteractionRowState extends State<InteractionRow> {
  HttpService _hs = HttpService();
  @override
  Widget build(BuildContext context) {
    Post post = Provider.of<Post>(context);

    return Column(
      children: <Widget>[
        Divider(
          thickness: 2.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                //Text('${post.comments.length}'),
                FutureBuilder(
                  future: _hs.getCommentCount(post.id),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      /*case ConnectionState.none:
                        return Text('0');
                        break;
                      case ConnectionState.waiting:
                        return Text('0');
                        break;
                      case ConnectionState.active:
                        return Text('0');
                        break;
                      */
                      case ConnectionState.done:
                        return Text('${snapshot.data}');
                        break;
                      default:
                        return Text('0');
                        break;
                    }
                  },
                ),
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
        Divider(
          thickness: 2.0,
        ),
      ],
    );
  }
}
