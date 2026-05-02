import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'study_planner_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final savedUsername = prefs.getString('username');

  runApp(
    StudyPlannerApp(
      savedUsername: savedUsername,
    ),
  );
}

class StudyPlannerApp extends StatelessWidget {
  final String? savedUsername;

  const StudyPlannerApp({
    super.key,
    this.savedUsername,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Planner',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
      },
      home: savedUsername != null
          ? StudyPlannerHomeScreen(username: savedUsername!)
          : const LoginScreen(),
    );
  }
}