import 'package:expenser_378/data/local/model/user_model.dart';

abstract class UserEvent{}

class SignUpEvent extends UserEvent{
  UserModel user;
  SignUpEvent({required this.user});
}

class LoginEvent extends UserEvent{
  String email;
  String pass;
  LoginEvent({required this.email, required this.pass});
}