import 'package:flutter/material.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  final TextEditingController subjectController = TextEditingController();

  String selectedColor = "Blue";

  final List<Map<String, dynamic>> subjects = [
    {"name": "Mathematics", "color": Colors.blue},
    {"name": "Science", "color": Colors.green},
    {"name": "English", "color": Colors.orange},
    {"name": "Computer", "color": Colors.purple},
    {"name": "History", "color": Colors.teal},
  ];

  Color getColor(String color) {
    switch (color) {
      case "Green":
        return Colors.green;
      case "Orange":
        return Colors.orange;
      case "Purple":
        return Colors.purple;
      case "Teal":
        return Colors.teal;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subjects"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(
                labelText: "Enter Subject Name",
                prefixIcon: Icon(Icons.book),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: selectedColor,
              decoration: const InputDecoration(
                labelText: "Choose Color",
                border: OutlineInputBorder(),
              ),
              items: ["Blue", "Green", "Orange", "Purple", "Teal"]
                  .map(
                    (color) => DropdownMenuItem(
                      value: color,
                      child: Text(color),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedColor = value!;
                });
              },
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                if (subjectController.text.trim().isNotEmpty) {
                  setState(() {
                    subjects.add({
                      "name": subjectController.text.trim(),
                      "color": getColor(selectedColor),
                    });
                    subjectController.clear();
                  });
                }
              },
              child: const Text("Add Subject"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: subjects[index]["color"],
                        child: const Icon(
                          Icons.menu_book,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        subjects[index]["name"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "Study ${subjects[index]["name"]}",
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            subjects.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}