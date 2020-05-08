// Model class for a user
class User {
  int uid;
  String username;
  String email;
  String password;
  String firstName;
  String lastName;
  String dateOfBirth;

  User(
      {this.uid,
      this.username,
      this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.dateOfBirth});

  // Creates a user object from json returned from an http request. Will only work for one user
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['user_id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      dateOfBirth: json['date_of_birth'] as String,
    );
  }

  // TODO Create a User factory to return a list of users from a list of json users
}

///**
///Query for displaying only posts of friends. Wrote it down so I wouldn't forget it
///Needs to be adjusted since we're putting the creator of the post in a different table
///
///SELECT *
///FROM post p
///JOIN friend f
///WHERE p.user_id = f.friend_id
///OR p.user_id = f.user_id
///ORDER BY p.created_at;
///**///
