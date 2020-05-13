// Model class for a comment.
class Comment {
  String firstName;
  String lastName;
  String username;
  String body;
  String createdAt;

  Comment(
      {this.firstName,
      this.lastName,
      this.username,
      this.body,
      this.createdAt});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      body: json['content'],
      createdAt: json['created_at'],
    );
  }
}

// Model class for a list of comments decoded from json.
class CommentList {
  List<Comment> comments;

  CommentList({this.comments});

  factory CommentList.fromJson(List<dynamic> json) {
    List<Comment> result = [];

    for (var comment in json) {
      result.add(Comment.fromJson(comment));
    }

    return CommentList(comments: result);
  }
}
