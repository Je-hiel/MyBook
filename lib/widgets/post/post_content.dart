import 'package:flutter/material.dart';
import 'package:mybook/models/post.dart';
import 'package:mybook/widgets/post/post_photos.dart';
import 'package:provider/provider.dart';
import 'package:mybook/constants.dart';

class PostContent extends StatelessWidget {
  final bool preview;

  PostContent({this.preview});

  @override
  Widget build(BuildContext context) {
    Post post = Provider.of<Post>(context);

    return preview
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Post title
              Text(
                post.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: titleStyle, //.copyWith(fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              // Post text
              Text(
                post.body,
                overflow: TextOverflow.fade,
                maxLines: 7,
                style: bodyStyle,
              ),
              SizedBox(height: 10.0),
              // Post images (if any)
              Visibility(
                visible: post.hasImages(),
                child: PostPhotos(imageURLs: post.images),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                post.title,
                style: titleStyle,
              ),
              SizedBox(height: 10.0),
              // Post text
              Text(
                post.body,
                style: bodyStyle,
              ),
              SizedBox(height: 10.0),
              // Post images (if any)
              Visibility(
                visible: post.hasImages(),
                child: PostPhotos(imageURLs: post.images),
              ),
            ],
          );
  }
}
