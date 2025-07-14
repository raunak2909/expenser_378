import '../../../data/local/model/user_model.dart';

abstract class UserState{}

class UserInitialState extends UserState{}
class UserLoadingState extends UserState{}
class UserSuccessState extends UserState{}
class UserLoadedState extends UserState{
  UserModel userModel;
  UserLoadedState({required this.userModel});
}
class UserFailureState extends UserState{
  String errorMsg;
  UserFailureState({required this.errorMsg});
}