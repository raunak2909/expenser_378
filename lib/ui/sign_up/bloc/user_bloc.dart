import 'package:expenser_378/data/local/repository/user_repository.dart';
import 'package:expenser_378/ui/sign_up/bloc/user_event.dart';
import 'package:expenser_378/ui/sign_up/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitialState()){

    on<SignUpEvent>((event, emit) async{

      emit(UserLoadingState());

      String msg = await userRepository.signUpUser(user: event.user);

      print(msg);
      if(msg=="Successfully registered!!"){
        emit(UserSuccessState());
      } else {
        emit(UserFailureState(errorMsg: msg));
      }

    });

    on<LoginEvent>((event, emit) async{

      emit(UserLoadingState());

      int msg = await userRepository.authenticateUser(email: event.email, pass: event.pass);

      if(msg==1){
        emit(UserSuccessState());
      } else if(msg==2){
        emit(UserFailureState(errorMsg: "Email does not exist"));
      } else {
        emit(UserFailureState(errorMsg: "Incorrect Password"));
      }


    });

  }

}