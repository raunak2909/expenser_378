import 'package:expenser_378/data/local/helper/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_constants.dart';
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

  Future<int> authenticateUser({required String email, required String pass}) async {
    if(await dbHelper.checkIfEmailExists(email: email)){

      int userId = await dbHelper.authenticateUser(email: email, pass: pass);

      if(userId>0){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt(AppConstants.PREF_USER_ID_KEY, userId);
        return 1;
      } else {
        return 3;
      }

    } else {
      return 2;
    }
  }

}