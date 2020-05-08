import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PostPhotos extends StatelessWidget {
  final List<String> imageURLs;
  final PageStorageBucket imagesBucket = PageStorageBucket();

  PostPhotos({this.imageURLs});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: PageStorage(
        bucket: imagesBucket,
        child: PhotoViewGallery.builder(
          itemCount: imageURLs.length,
          builder: (context, imageIndex) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(
                imageURLs[imageIndex],
              ),
              // Contained = the smallest possible size to fit one dimension of the screen
              minScale: PhotoViewComputedScale.contained * 0.7,
              // Covered = the smallest possible size to fit the whole screen
              maxScale: PhotoViewComputedScale.covered * 2.5,
            );
          },
          scrollPhysics: BouncingScrollPhysics(),
          // Set the background color to the "classic white"
          backgroundDecoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          loadingBuilder:
              (BuildContext context, ImageChunkEvent loadingProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
