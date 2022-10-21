class User {
  String name;
  String email;
  String password;

  User({required this.name, required this.email, required this.password});

  String getName() => this.name;
  String getEmail() => this.email;
  String getPassword() => this.password;

  String toString() => this.name;
}