import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();

  double _studyHours = 4; // Default daily study hours
  String _studyGoal = 'Exam Preparation';

  List<String> _studyGoals = [
    'Exam Preparation',
    'Daily Learning',
    'Skill Development',
    'Project Work',
    'Competitive Exams',
    'Language Learning',
    'Coding Practice',
  ];

  List<String> selectedSubjects = [];

  List<String> availableSubjects = [
    'Mathematics',
    'Science',
    'Programming',
    'English',
    'History',
    'Data Structures',
    'Machine Learning',
    'Database',
    'Networking',
    'Research Work'
  ];

  void _register() {
    print("Study Planner Registration");
    print("Name: ${_nameController.text}");
    print("Username: ${_usernameController.text}");
    print("Study Hours: ${_studyHours.round()}");
    print("Goal: $_studyGoal");
    print("Subjects: $selectedSubjects");
  }

  void _toggleSubject(String subject) {
    setState(() {
      if (selectedSubjects.contains(subject)) {
        selectedSubjects.remove(subject);
      } else {
        selectedSubjects.add(subject);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade700,
        title: const Text(
          'Study Planner Setup',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade700, Colors.indigo.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputField(
                  _nameController,
                  'Student Name',
                  Icons.person,
                ),
                const SizedBox(height: 12),

                _buildInputField(
                  _usernameController,
                  'Username',
                  Icons.alternate_email,
                ),
                const SizedBox(height: 20),

                Text(
                  'Daily Study Hours: ${_studyHours.round()} hrs',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),

                Slider(
                  value: _studyHours,
                  min: 1,
                  max: 12,
                  divisions: 11,
                  activeColor: Colors.indigo.shade300,
                  inactiveColor: Colors.indigo.shade100,
                  onChanged: (double value) {
                    setState(() {
                      _studyHours = value;
                    });
                  },
                ),

                const SizedBox(height: 15),

                _buildGoalDropdown(),

                const SizedBox(height: 20),

                const Text(
                  'Select Subjects to Focus On',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: availableSubjects.map((subject) {
                    final isSelected = selectedSubjects.contains(subject);

                    return GestureDetector(
                      onTap: () => _toggleSubject(subject),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.indigo.shade400
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.indigo.shade700,
                          ),
                        ),
                        child: Text(
                          subject,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.indigo.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 30),

                Center(
                  child: ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 70,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      'Create Planner',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String hint,
    IconData icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.indigo.shade700,
          ),
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildGoalDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButton<String>(
        value: _studyGoal,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.indigo.shade700,
        ),
        isExpanded: true,
        underline: const SizedBox(),
        items: _studyGoals.map((String goal) {
          return DropdownMenuItem<String>(
            value: goal,
            child: Text(goal),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _studyGoal = newValue!;
          });
        },
      ),
    );
  }
}
