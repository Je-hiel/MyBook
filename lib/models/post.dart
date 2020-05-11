import 'package:mybook/models/comment.dart';

// Model class for a post
// TODO Set up userID, likes counter, attach comments, attach time created...
// TODO Save some user data of person that created the post.
class Post {
  String createdAt;
  String title;
  String body;
  List<String> images = [];
  List<Comment> comments = [];
  int likesCount = 0;
  int dislikesCount = 0;

  // TODO Sort out logic error with keeping track of like and dislike status on the post itself.
  bool liked = false;
  bool disliked = false;
  bool commented = false;

  /*Post(
      {this.title,
      this.body,
      this.images = const [],
      this.comments = const []});*/

  Post({this.title, this.body, this.createdAt});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      body: json['content'],
      createdAt: json['created_at'],
    );
  }

  bool hasImages() {
    return images.length > 0;
  }

  bool hasComments() {
    return comments.length > 0;
  }

  void incrementLikes() {
    likesCount++;
  }

  void decrementLikes() {
    likesCount--;
  }

  void incrementDislikes() {
    dislikesCount++;
  }

  void decrementDislikes() {
    dislikesCount--;
  }

  void likePost() {
    // If the user already disliked the post
    if (disliked) {
      decrementDislikes();
    }

    // If the user already liked the post
    if (liked) {
      decrementLikes();
      liked = false;
      disliked = false;
    } else {
      incrementLikes();
      liked = true;
      disliked = false;
    }
  }

  void dislikePost() {
    // If the user already liked the post
    if (liked) {
      decrementLikes();
    }

    if (disliked) {
      decrementDislikes();
      liked = false;
      disliked = false;
    } else {
      incrementDislikes();
      liked = false;
      disliked = true;
    }
  }

  void addComment(String body) {
    commented = true;
    comments.add(Comment(
      body: body,
    ));
  }
}

class PostList {
  List<Post> posts;

  PostList({this.posts});

  factory PostList.fromJson(List<dynamic> json) {
    List<Post> result = [];

    for (var post in json) {
      result.add(Post.fromJson(post));
    }

    return PostList(posts: result);
  }
}

/*
List<Post> posts = [
  Post(
    title: 'Hello world!',
    body:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec pellentesque tellus. Donec egestas metus sit amet cursus sagittis.',
    images: [
      'https://pbs.twimg.com/profile_images/949787136030539782/LnRrYf6e_400x400.jpg',
      'https://image.shutterstock.com/image-photo/theres-song-every-emotion-adorable-260nw-1406667083.jpg',
      'https://www.liveabout.com/thmb/jyBQcDiXM_ysKfIHu88GvvW-20U=/1300x866/filters:no_upscale():max_bytes(150000):strip_icc()/loan-599c450a03f40200117e717a.jpg',
      'https://c8.alamy.com/comp/F8DG4T/businessman-with-thoughts-of-suicide-F8DG4T.jpg',
      'https://www.apimages.com/Images/Ap_Creative_Stock_Header.jpg',
    ],
    comments: [
      Comment(body: 'Great!'),
      Comment(body: 'Hoorah'),
      Comment(body: 'Howzat'),
      Comment(body: 'Impeccable'),
      Comment(body: 'Agueroooooooooooo'),
      Comment(body: 'Didn\'t think you had it in you'),
    ],
  ),
  Post(
    title: 'How are you my peeps?',
    body:
        'Donec eu consectetur dolor. Aenean sed odio et metus tincidunt aliquam. Mauris sit amet egestas arcu. Nullam tempus, mi et rhoncus mattis, ex arcu mollis diam, et suscipit nisl sapien eget est. In iaculis porta lorem, eget gravida arcu convallis eget. Vivamus ac urna nec risus vulputate elementum. Nullam eleifend elit vestibulum justo rutrum, at auctor erat sagittis. Curabitur quis euismod velit, sit amet efficitur diam. Nullam at lacus nisl. Praesent mollis pharetra lacus, sed ullamcorper mauris porta non. Proin non sagittis ipsum.',
    images: [],
    comments: [
      Comment(
          body:
              'Blah blah blah blah blah blah blah blah blah blah blah blah blah blah'),
    ],
  ),
  Post(
    title: 'Just landed safely',
    body:
        'Cras blandit eros eget porta consequat. Curabitur tempus ultrices tellus, et hendrerit tellus ultrices eu. In nec ipsum in metus pulvinar blandit. Sed ultrices id nisl quis varius. Suspendisse sed scelerisque eros. Proin luctus sodales augue. Proin vestibulum elit ut lectus egestas lobortis. Vestibulum imperdiet lacus ac feugiat bibendum.',
    images: [
      'https://media.gettyimages.com/photos/woman-using-a-computer-picture-id846202328?s=612x612',
      'https://media.istockphoto.com/photos/young-boy-working-on-a-laptop-computer-stock-image-picture-id1077332896',
    ],
    comments: [
      Comment(body: 'Oops'),
      Comment(body: 'I'),
      Comment(body: 'Did '),
      Comment(body: 'It'),
      Comment(body: 'Again'),
      Comment(body: 'The quick brown fox jumps over the lazy rabbit.'),
      Comment(
          body:
              'Yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah yeah'),
    ],
  ),
  Post(
    title: 'Worst day ever',
    body:
        'In sagittis ornare nisl. Nam volutpat, libero porta laoreet porta, sapien justo iaculis ipsum, a aliquam orci augue vel erat. Nulla ut nunc pulvinar, faucibus ligula vitae, scelerisque arcu.',
    images: [],
  ),
  Post(
    title: 'Living my best life',
    body:
        'Etiam faucibus pharetra elit nec vulputate. Integer consequat, ex porta accumsan commodo, arcu ligula vestibulum sapien, quis dictum diam ante at sem. In consectetur euismod dolor, pretium accumsan mi semper sed. In at condimentum nulla. Cras bibendum mollis sodales. Proin ligula nisi, commodo et dolor vel, posuere interdum quam. \n\nDonec eu consectetur dolor. Aenean sed odio et metus tincidunt aliquam. Mauris sit amet egestas arcu. Nullam tempus, mi et rhoncus mattis, ex arcu mollis diam, et suscipit nisl sapien eget est. In iaculis porta lorem, eget gravida arcu convallis eget. Vivamus ac urna nec risus vulputate elementum. Nullam eleifend elit vestibulum justo rutrum, at auctor erat sagittis. Curabitur quis euismod velit, sit amet efficitur diam. \n\nNullam at lacus nisl. Praesent mollis pharetra lacus, sed ullamcorper mauris porta non. Proin non sagittis ipsum. Donec eu consectetur dolor. Aenean sed odio et metus tincidunt aliquam. Mauris sit amet egestas arcu. Nullam tempus, mi et rhoncus mattis, ex arcu mollis diam, et suscipit nisl sapien eget est. In iaculis porta lorem, eget gravida arcu convallis eget. Vivamus ac urna nec risus vulputate elementum. Nullam eleifend elit vestibulum justo rutrum, at auctor erat sagittis. Curabitur quis euismod velit, sit amet efficitur diam. Nullam at lacus nisl. Praesent mollis pharetra lacus, sed ullamcorper mauris porta non. Proin non sagittis ipsum.',
    images: [
      'https://img3.stockfresh.com/files/m/monkey_business/m/84/82578_stock-photo-college-students-in-a-computer-lab.jpg',
      'https://images.pexels.com/photos/267885/pexels-photo-267885.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'https://previews.123rf.com/images/wavebreakmediamicro/wavebreakmediamicro1302/wavebreakmediamicro130200291/18125976-mature-students-taking-notes-in-lecture-in-college.jpg',
    ],
    comments: [
      Comment(body: 'Wow what a test'),
      Comment(body: 'Sending thoughts and prayers'),
    ],
  ),
];
*/
