import 'package:flutter/material.dart';

class SubjectDetailScreen extends StatelessWidget {
  const SubjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> subjects = [
      "Mathematics",
      "Science",
      "English",
      "Computer Science",
      "History",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Subjects"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            child: ListTile(
              leading: const Icon(
                Icons.menu_book,
                color: Colors.deepPurple,
              ),
              title: Text(subjects[index]),
              subtitle: Text(
                "Detailed information about ${subjects[index]}",
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${subjects[index]} selected"),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
