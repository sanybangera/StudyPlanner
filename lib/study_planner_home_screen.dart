import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'subject_detail_screen.dart';

class StudyPlannerHomeScreen extends StatefulWidget {
  final String username;

  const StudyPlannerHomeScreen({
    super.key,
    required this.username,
  });

  @override
  State<StudyPlannerHomeScreen> createState() =>
      _StudyPlannerHomeScreenState();
}

class _StudyPlannerHomeScreenState
    extends State<StudyPlannerHomeScreen> {
  Map<String, dynamic>? userProfile;
  List<String> subjects = [];
  String notification = "";
  String lastAction = "";

  @override
  void initState() {
    super.initState();
    _loadStoredData();
  }

  // LOAD ALL STORED DATA
  Future<void> _loadStoredData() async {
    final prefs = await SharedPreferences.getInstance();

    final profileData = prefs.getString('user_profile');
    final savedSubjects =
        prefs.getStringList('subjects') ?? [];
    final savedNotification =
        prefs.getString('notification') ?? "";
    final savedAction =
        prefs.getString('last_action') ?? "";

    setState(() {
      if (profileData != null) {
        userProfile =
            jsonDecode(profileData) as Map<String, dynamic>;
      }

      subjects = savedSubjects;
      notification = savedNotification;
      lastAction = savedAction;
    });
  }

  // SIGN OUT + CLEAR LOCAL STORAGE
  Future<void> _signOut() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('username');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Signed Out Successfully"),
      ),
    );

    Navigator.pushReplacementNamed(
      context,
      '/login',
    );
  }

  Widget _buildProfileSection() {
    if (userProfile == null) {
      return const Text(
        "No profile data found.",
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey,
        ),
      );
    }

    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Name: ${userProfile!['name']}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Username: ${userProfile!['username']}",
            ),
            Text(
              "Study Goal: ${userProfile!['studyGoal']}",
            ),
            Text(
              "Daily Study Hours: ${userProfile!['studyHours']} hrs",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectsSection() {
    if (subjects.isEmpty) {
      return const Text(
        "No subjects selected.",
      );
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: subjects.map((subject) {
        return Card(
          child: ListTile(
            leading: const Icon(
              Icons.book,
              color: Colors.deepPurple,
            ),
            title: Text(subject),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNotificationSection() {
    if (notification.isEmpty) {
      return const SizedBox();
    }

    return Card(
      color: Colors.amber.shade100,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: const Icon(
          Icons.notifications,
          color: Colors.orange,
        ),
        title: Text(notification),
        subtitle: Text(
          "Last Action: $lastAction",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Planner"),
        backgroundColor: Colors.deepPurple,
      ),

      // SIDE MENU
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
              accountName: Text(widget.username),
              accountEmail: const Text(
                "student@studyplanner.com",
              ),
              currentAccountPicture:
                  const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.deepPurple,
                ),
              ),
            ),

            // SUBJECTS
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("Subjects"),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const SubjectDetailScreen(),
                  ),
                );
              },
            ),

            // PERSONAL INFO
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Personal Info"),
              onTap: () {
                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text(
                      "Personal Info",
                    ),
                    content: userProfile == null
                        ? const Text(
                            "No personal info stored.")
                        : Text(
                            "Name: ${userProfile!['name']}\nUsername: ${userProfile!['username']}\nGoal: ${userProfile!['studyGoal']}",
                          ),
                  ),
                );
              },
            ),

            // REPORTS
            ListTile(
              leading:
                  const Icon(Icons.bar_chart),
              title: const Text("Reports"),
              onTap: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      "You have ${subjects.length} active subjects.",
                    ),
                  ),
                );
              },
            ),

            // NOTIFICATIONS
            ListTile(
              leading: const Icon(
                Icons.notifications,
              ),
              title:
                  const Text("Notifications"),
              onTap: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      notification.isEmpty
                          ? "No notifications"
                          : notification,
                    ),
                  ),
                );
              },
            ),

            const Divider(),

            // SIGN OUT
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                "Sign Out",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: _signOut,
            ),
          ],
        ),
      ),

      // MAIN BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Welcome, ${widget.username}!",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 20),

            // PROFILE SECTION
            _buildProfileSection(),

            const SizedBox(height: 20),

            const Align(
              alignment:
                  Alignment.centerLeft,
              child: Text(
                "Your Subjects:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            _buildSubjectsSection(),

            const SizedBox(height: 20),

            // NOTIFICATIONS
            _buildNotificationSection(),
          ],
        ),
      ),
    );
  }
}