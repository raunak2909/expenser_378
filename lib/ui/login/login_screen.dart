import 'package:expenser_378/ui/sign_up/bloc/user_bloc.dart';
import 'package:expenser_378/ui/sign_up/bloc/user_event.dart';
import 'package:expenser_378/ui/sign_up/bloc/user_state.dart';
import 'package:expenser_378/ui/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  bool? isLoading;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildLoginForm(context)],
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Login to your Account !",
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Enter your Email here..",
            prefixIcon: Icon(Icons.email),
            labelText: "Email",
            filled: true,
            fillColor: Color(0xFFDDF6D2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(Icons.lock),
            filled: true,
            fillColor: Color(0xFFDDF6D2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: BlocConsumer<UserBloc, UserState>(
            listenWhen: (ps, cs){
              if(isLoading!=null){
                return true;
              } else {
                return false;
              }
            },
            buildWhen: (ps, cs){
              if(isLoading!=null){
                return true;
              } else {
                return false;
              }
            },
            listener: (_, state){

              if(state is UserLoadingState){
                isLoading = true;
              }

              if(state is UserFailureState){
                isLoading = false;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
              }

              if(state is UserSuccessState){
                isLoading = false;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged in successfully!!")));
                Navigator.pushReplacementNamed(context, AppRoutes.HOMEPAGE);
              }

            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  isLoading = false;
                  context.read<UserBloc>().add(
                    LoginEvent(
                      email: emailController.text,
                      pass: passwordController.text,
                    ),
                  );

                  //login logic here..

                  /*Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => HomeScreen()));*/
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB0DB9C),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isLoading!=null && isLoading! ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.white,),
                    SizedBox(width: 8),
                    Text(
                      "Logging in...",
                      style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
                    ),
                  ],
                ) : Text(
                  "Login",
                  style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
                ),
              );
            }
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account? "),
            InkWell(
              onTap: () {
                isLoading = null;
                Navigator.of(context).pushNamed(AppRoutes.SIGNUPPAGE);
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6BCB77),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
