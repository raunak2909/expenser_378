import 'package:expenser_378/data/local/model/cat_model.dart';

class AppConstants{

  static const String PREF_USER_ID_KEY = "uid";

  static List<CategoryModel> mCatList = [
    CategoryModel(catId: 1, catName: "Coffee", catImg: "assets/icons/coffee.png"),
    CategoryModel(catId: 2, catName: "FastFood", catImg: "assets/icons/fast-food.png"),
    CategoryModel(catId: 3, catName: "Recharge", catImg: "assets/icons/smartphone.png"),
    CategoryModel(catId: 4, catName: "Snacks", catImg: "assets/icons/snack.png"),
    CategoryModel(catId: 5, catName: "Travel", catImg: "assets/icons/travel.png"),
    CategoryModel(catId: 6, catName: "Petrol", catImg: "assets/icons/vehicles.png"),
    CategoryModel(catId: 7, catName: "Groceries", catImg: "assets/icons/shopping-bag.png"),
  ];

}