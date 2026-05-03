import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  Widget buildStatusIcon(bool completed) {
    return Icon(
      completed ? Icons.check_circle : Icons.cancel,
      color: completed ? Colors.green : Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> weeklySubjects = [
      {
        "subject": "Mathematics",
        "mon": true,
        "tue": true,
        "wed": false,
      },
      {
        "subject": "Science",
        "mon": true,
        "tue": false,
        "wed": true,
      },
      {
        "subject": "English",
        "mon": false,
        "tue": true,
        "wed": true,
      },
      {
        "subject": "Computer",
        "mon": true,
        "tue": true,
        "wed": true,
      },
      {
        "subject": "History",
        "mon": false,
        "tue": true,
        "wed": false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weekly Reports"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            border: TableBorder.all(
              color: Colors.grey,
            ),
            defaultColumnWidth:
                const FixedColumnWidth(80),
            children: [
              const TableRow(
                decoration: BoxDecoration(
                  color: Color(0xFFE3F2FD),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Subject",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Mon"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Tue"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Wed"),
                  ),
                ],
              ),

              ...weeklySubjects.map(
                (subject) => TableRow(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.all(
                              8),
                      child: Text(
                        subject["subject"],
                      ),
                    ),
                    Center(
                      child:
                          buildStatusIcon(
                        subject["mon"],
                      ),
                    ),
                    Center(
                      child:
                          buildStatusIcon(
                        subject["tue"],
                      ),
                    ),
                    Center(
                      child:
                          buildStatusIcon(
                        subject["wed"],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}