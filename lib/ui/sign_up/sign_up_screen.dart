import 'package:expenser_378/ui/sign_up/bloc/user_bloc.dart';
import 'package:expenser_378/ui/sign_up/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local/model/user_model.dart';
import 'bloc/user_state.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildTextFields(context)],
        ),
      ),
    );
  }

  Widget _buildTextFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Create Account",
          style: TextStyle(
            fontSize: 24,
            //color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: "Full Name",
            prefixIcon: Icon(Icons.person),
            filled: true,
            //fillColor: Color(0xFFDDF6D2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(Icons.email),
            filled: true,
            //fillColor: Color(0xFFDDF6D2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: mobController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: "Phone Number",
            prefixIcon: Icon(Icons.phone),
            filled: true,
            //fillColor: Color(0xFFDDF6D2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(Icons.lock),
            filled: true,
            //fillColor: Color(0xFFDDF6D2),
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
                builder: (_, state){
                  return ElevatedButton(
                    onPressed: () {
                      // signUp logic

                      UserModel mUser = UserModel(
                        name: nameController.text,
                        email: emailController.text,
                        mobNo: mobController.text,
                        pass: passController.text,
                      );

                      context.read<UserBloc>().add(SignUpEvent(user: mUser));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB0DB9C),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.white,),
                        SizedBox(width: 11,),
                        Text("Signing Up...")
                      ],
                    ) : Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
                    ),
                  );
                },
                listener: (context, state) {
                  if (state is UserLoadingState) {
                    isLoading = true;
                  }

                  if (state is UserSuccessState) {
                    isLoading = false;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Successfully registered!!")));
                    Navigator.pop(context);
                    /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: Text('Home'),
                      ),
                      body: Center(child: Text("Home"))
                    ),));*/
                  }

                  if (state is UserFailureState) {
                    isLoading = false;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  }
                },

              )
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account? "),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Login",
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
