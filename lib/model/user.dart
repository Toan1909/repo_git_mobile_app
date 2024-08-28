class User {
  late String fullName;
  late String email;
  late String token;
  User({required this.fullName, required this.email});
  User.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    token = json['token'];
  }
}
