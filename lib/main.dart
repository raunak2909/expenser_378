import 'package:expenser_378/data/local/helper/db_helper.dart';
import 'package:expenser_378/data/local/repository/expense_repository.dart';
import 'package:expenser_378/data/local/repository/user_repository.dart';
import 'package:expenser_378/ui/dashboard_page/nav_pages/home/bloc/expense_bloc.dart';
import 'package:expenser_378/ui/sign_up/bloc/user_bloc.dart';
import 'package:expenser_378/ui/theme_provider.dart';
import 'package:expenser_378/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(
            userRepository: UserRepository(dbHelper: DBHelper.getInstance()),
          ),
        ),
        BlocProvider(
          create: (_) => ExpenseBloc(
            expenseRepository: ExpenseRepository(
              dbHelper: DBHelper.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
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
      themeMode: context.watch<ThemeProvider>().getThemeValue()
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData(brightness: Brightness.dark,
          textTheme: TextTheme(
            headlineLarge: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
            headlineSmall: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            labelLarge: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          )
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff6750a4)),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          labelSmall: TextStyle(
            fontSize: 11,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),

      ),
      initialRoute: AppRoutes.SPLASHPAGE,
      routes: AppRoutes.routes,
    );
  }
}
