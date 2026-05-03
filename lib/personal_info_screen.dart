import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatefulWidget {
  final String name;
  final String username;
  final int age;

  const PersonalInfoScreen({
    super.key,
    required this.name,
    required this.username,
    required this.age,
  });

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController ageController;

  String selectedGoal = "Exam Preparation";

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    usernameController = TextEditingController(text: widget.username);
    ageController = TextEditingController(text: widget.age.toString());
  }

  Widget customField(
      TextEditingController controller, String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Info"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            customField(nameController, "Name", Icons.person),
            customField(usernameController, "Username", Icons.alternate_email),
            customField(ageController, "Age", Icons.cake),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedGoal,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: ["Exam Preparation", "Skill Building", "Daily Study"]
                  .map((goal) => DropdownMenuItem(
                        value: goal,
                        child: Text(goal),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedGoal = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: () {
                Navigator.pop(context, {
                  "name": nameController.text,
                  "username": usernameController.text,
                  "age": int.tryParse(ageController.text) ?? 18,
                });
              },
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}