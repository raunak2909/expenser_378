import 'dart:io';

import 'package:expenser_378/data/local/model/user_model.dart';
import 'package:expenser_378/utils/app_constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static DBHelper getInstance() => DBHelper._();

  Database? mDB;

  ///user table
  static const String TABLE_USER = "user";
  static const String COLUMN_USER_ID = "u_id";
  static const String COLUMN_USER_NAME = "u_name";
  static const String COLUMN_USER_EMAIL = "u_email";
  static const String COLUMN_USER_MOB_NO = "u_mob_no";
  static const String COLUMN_USER_PASS = "u_pass";

  ///expense table
  static const String TABLE_EXPENSE = "expense";
  static const String COLUMN_EXPENSE_ID = "e_id";
  static const String COLUMN_EXPENSE_TITLE = "e_title";
  static const String COLUMN_EXPENSE_DESC = "e_desc";
  static const String COLUMN_EXPENSE_AMOUNT = "e_amount";
  static const String COLUMN_EXPENSE_BAL = "e_bal";
  static const String COLUMN_EXPENSE_CREATED_AT = "e_created_at";
  static const String COLUMN_EXPENSE_CAT_ID = "e_cat_id";
  static const String COLUMN_EXPENSE_TYPE = "e_type";

  Future<Database> initDB() async {
    mDB ??= await openDB();
    return mDB!;
  }

  Future<Database> openDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = join(dir.path, "expenseDB.db");
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE $TABLE_USER ($COLUMN_USER_ID INTEGER PRIMARY KEY AUTOINCREMENT, $COLUMN_USER_NAME TEXT, $COLUMN_USER_EMAIL TEXT, $COLUMN_USER_MOB_NO TEXT, $COLUMN_USER_PASS TEXT)",
        );
        db.execute(
          "CREATE TABLE $TABLE_EXPENSE ($COLUMN_EXPENSE_ID INTEGER PRIMARY KEY AUTOINCREMENT, $COLUMN_USER_ID INTEGER, $COLUMN_EXPENSE_TITLE TEXT, $COLUMN_EXPENSE_DESC TEXT, $COLUMN_EXPENSE_AMOUNT INTEGER, $COLUMN_EXPENSE_BAL INTEGER, $COLUMN_EXPENSE_CREATED_AT TEXT, $COLUMN_EXPENSE_CAT_ID INTEGER, $COLUMN_EXPENSE_TYPE TEXT)",
        );
      },
    );
  }

  ///events
  Future<bool> registerUser({required UserModel user}) async {
    var db = await initDB();
    int rowsEffected = await db.insert(TABLE_USER, user.toMap());
    return rowsEffected > 0;
  }

  Future<bool> checkIfEmailExists({required String email}) async {
    var db = await initDB();

    var data = await db.query(
      TABLE_USER,
      where: "$COLUMN_USER_EMAIL = ?",
      whereArgs: [email],
    );

    return data.isNotEmpty;
  }

  Future<int> authenticateUser({
    required String email,
    required String pass,
  }) async {
    var db = await initDB();

    List<Map<String, dynamic>> allData = await db.query(
      TABLE_USER,
      where: "$COLUMN_USER_EMAIL = ? AND $COLUMN_USER_PASS = ?",
      whereArgs: [email, pass],
    );
    ///add userid in prefs
    /*if(allData.isNotEmpty){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(AppConstants.PREF_USER_ID_KEY, allData[0][COLUMN_USER_ID]);
    }*/

    return allData.isNotEmpty ? allData[0][COLUMN_USER_ID] : 0;
  }
}
