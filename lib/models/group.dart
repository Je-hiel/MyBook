class Group {
  String name;

  Group({this.name});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(name: json['name']);
  }
}
