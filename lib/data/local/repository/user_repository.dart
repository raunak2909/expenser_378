import 'package:expenser_378/data/local/helper/db_helper.dart';

import '../model/user_model.dart';

class UserRepository{
  DBHelper dbHelper;
  UserRepository({required this.dbHelper});

  Future<String> signUpUser({required UserModel user}) async {
    if(await dbHelper.checkIfEmailExists(email: user.email)){
      return "Email already exists";
    } else {
      bool check = await dbHelper.registerUser(user: user);
      return check ? "Successfully registered!!" : "Failed to register..";
    }
  }

  authenticateUser({required String email, required String pass}) async {

  }

}