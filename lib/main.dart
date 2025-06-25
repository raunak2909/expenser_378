import 'package:expenser_378/data/local/helper/db_helper.dart';
import 'package:expenser_378/data/local/repository/user_repository.dart';
import 'package:expenser_378/ui/sign_up/bloc/user_bloc.dart';
import 'package:expenser_378/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => UserBloc(
        userRepository: UserRepository(
            dbHelper: DBHelper.getInstance()),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.SPLASHPAGE,
      routes: AppRoutes.routes,
    );
  }
}
