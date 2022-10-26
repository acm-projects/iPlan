import '/Backend/User_Creation/user_creator.dart';

void main() async {
  int code = await UserCreator.createNewUser(
      email: "jon.perry@gmail.com", password: "welcome", name: "Jon Perry");
  print(code);
}
