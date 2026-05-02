import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_screen.dart';
import 'study_planner_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  Map<String, dynamic>? savedUserData;

  @override
  void initState() {
    super.initState();
    _loadSavedUser();
  }

  // LOAD SAVED USER PROFILE FROM LOCAL STORAGE
  Future<void> _loadSavedUser() async {
    final prefs = await SharedPreferences.getInstance();

    final userProfile = prefs.getString('user_profile');

    if (userProfile != null) {
      setState(() {
        savedUserData =
            jsonDecode(userProfile) as Map<String, dynamic>;

        // Autofill username if available
        _usernameController.text =
            savedUserData!['username'] ?? '';
      });
    }
  }

  // SAVE LOGIN ACTION + NOTIFICATION
  Future<void> _saveLoginData(String username) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'username',
      username,
    );

    await prefs.setString(
      'last_action',
      'User Logged In Successfully',
    );

    await prefs.setString(
      'notification',
      'Welcome back, $username!',
    );
  }

  void _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter username and password",
          ),
        ),
      );
      return;
    }

    // Validate against saved registration data
    if (savedUserData != null &&
        savedUserData!['username'] != username) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Username not found. Please register first.",
          ),
        ),
      );
      return;
    }

    // Save login info
    await _saveLoginData(username);

    // Navigate to Home Screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StudyPlannerHomeScreen(
          username: username,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildStoredProfileCard() {
    if (savedUserData == null) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white30,
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Saved User Profile Found",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Name: ${savedUserData!['name']}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            "Goal: ${savedUserData!['studyGoal']}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            "Study Hours: ${savedUserData!['studyHours']} hrs",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade700,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Column(
            children: [
              const Text(
                "Study Planner Login",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // CONDITIONAL RENDERING OF SAVED PROFILE
              _buildStoredProfileCard(),

              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Username",
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.indigo.shade400,
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const RegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  "New User? Register",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}