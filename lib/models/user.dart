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

  // Creates a user object from json returned from an http request. Will only work for one user.
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

  // Creates a list of users from json list.
  List<User> getUserListFromJson(List<dynamic> json) {
    List<User> result = [];

    for (var jsonUser in json) {
      result.add(User.fromJson(jsonUser));
    }

    return result;
  }
}
