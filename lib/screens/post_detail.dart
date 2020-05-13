import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:mybook/models/comment.dart';
import 'package:mybook/models/post.dart';
import 'package:mybook/services/auth_service.dart';
import 'package:mybook/services/http_service.dart';
import 'package:mybook/widgets/post/comment_tile.dart';
import 'package:mybook/widgets/post/interaction_row.dart';
import 'package:mybook/widgets/post/post_content.dart';
import 'package:mybook/widgets/post/post_header.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatefulWidget {
  Post post;

  PostDetail({this.post});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final _commentsCache = new AsyncCache<List<Comment>>(Duration(minutes: 5));
  final TextEditingController _commentController = TextEditingController();
  final HttpService _hs = new HttpService();
  final AuthService _auth = new AuthService();
  String comment;

  Future<List<Comment>> getCommentsInCache() {
    return _commentsCache.fetch(() {
      return _hs.getComments(widget.post.id);
    });
  }

  @override
  void initState() {
    _commentsCache.invalidate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  PostHeader(timeDetail: true),
                  SizedBox(height: 20),
                  PostContent(preview: false),
                  SizedBox(height: 5.0),
                  InteractionRow(),
                  SizedBox(height: 10.0),
                  //Column(children: commentWidgets),
                  FutureBuilder(
                    future: getCommentsInCache(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Container(
                            height: 70.0,
                            color: Colors.grey,
                          );
                          break;
                        case ConnectionState.waiting:
                          return Container(
                            height: 70.0,
                            color: Colors.amber,
                          );
                          break;
                        case ConnectionState.active:
                          return Container(
                            height: 70.0,
                            color: Colors.green,
                          );
                          break;
                        case ConnectionState.done:
                          List<Comment> data = snapshot.data;

                          if (data.isEmpty) {
                            return Center(
                              child: Text('No comments yet...'),
                            );
                          } else {
                            List<Widget> commentWidgets2 = [];
                            for (var commentData in snapshot.data) {
                              commentWidgets2.add(
                                CommentTile(
                                  comment: commentData,
                                ),
                              );
                            }

                            return Column(children: commentWidgets2);
                          }
                          break;
                        default:
                          return Container(
                            height: 70.0,
                            color: Colors.red,
                          );
                      }
                    },
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                ],
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: Theme.of(context).canvasColor,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              hintText: 'Add a comment...',
                            ),
                            onChanged: (text) {
                              setState(() {
                                comment = text;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () async {
                            dynamic result = await _hs.addComment(
                                _auth.getUID(), widget.post.id, comment);

                            setState(() {
                              if (result.runtimeType == String) {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result),
                                  ),
                                );
                              } else {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Comment posted.'),
                                  ),
                                );
                                _commentsCache.invalidate();
                                _commentController.clear();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
