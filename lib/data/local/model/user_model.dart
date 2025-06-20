import 'package:expenser_378/data/local/helper/db_helper.dart';

class UserModel {
  int? id;
  String name;
  String email;
  String mobNo;
  String pass;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.mobNo,
    required this.pass,
  });

  /// convert map into model
  /*static UserModel fromMap(Map<String, dynamic> map){
    return UserModel(
        id: map[DBHelper.COLUMN_USER_ID],
        name: map[DBHelper.COLUMN_USER_NAME],
        email: map[DBHelper.COLUMN_USER_EMAIL],
        mobNo: map[DBHelper.COLUMN_USER_MOB_NO],
        pass: map[DBHelper.COLUMN_USER_PASS]);
  }*/
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[DBHelper.COLUMN_USER_ID],
      name: map[DBHelper.COLUMN_USER_NAME],
      email: map[DBHelper.COLUMN_USER_EMAIL],
      mobNo: map[DBHelper.COLUMN_USER_MOB_NO],
      pass: map[DBHelper.COLUMN_USER_PASS],
    );
  }

  /// convert model into map
  Map<String, dynamic> toMap() {
    return {
      DBHelper.COLUMN_USER_NAME : name,
      DBHelper.COLUMN_USER_EMAIL : email,
      DBHelper.COLUMN_USER_MOB_NO : mobNo,
      DBHelper.COLUMN_USER_PASS : pass,
    };
  }
}
