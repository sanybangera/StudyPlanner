import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'subjects_screen.dart';
import 'personal_info_screen.dart';
import 'reports_screen.dart';
import 'notifications_screen.dart';

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
  String name = "Student";
  String username = "student123";
  int age = 18;

  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Planner"),
        backgroundColor: Colors.blue,
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(username),
              accountEmail:
                  const Text("student@studyplanner.com"),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person, size: 40),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("Subjects"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const SubjectsScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Personal Info"),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PersonalInfoScreen(
                      name: name,
                      username: username,
                      age: age,
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    name = result["name"];
                    username = result["username"];
                    age = result["age"];
                  });
                }
              },
            ),

            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Reports"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const ReportsScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading:
                  const Icon(Icons.notifications),
              title:
                  const Text("Notifications"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const NotificationsScreen(),
                  ),
                );
              },
            ),

            const Divider(),

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
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: Center(
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                const Icon(
                  Icons.school,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                Text(
                  "Welcome, $username!",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text("Name: $name"),
                Text("Age: $age"),
                const SizedBox(height: 20),
                const Text(
                  "Use the menu to manage your study planner.",
                  textAlign:
                      TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}