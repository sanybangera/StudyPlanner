import 'package:flutter/material.dart';
import 'notifications_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool notificationsEnabled = false;

  final List<Map<String, dynamic>> reminders = [
    {"task": "Math Homework", "enabled": false},
    {"task": "Science Revision", "enabled": false},
    {"task": "English Reading", "enabled": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications Settings"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Enable Notifications"),
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
            const Divider(),

            Expanded(
              child: ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(reminders[index]["task"]),
                    value: reminders[index]["enabled"],
                    onChanged: notificationsEnabled
                        ? (value) {
                            setState(() {
                              reminders[index]["enabled"] = value!;
                            });
                          }
                        : null,
                  );
                },
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: notificationsEnabled
                  ? () async {
                      await NotificationService.showNotification(
                        title: "Study Reminder",
                        body: "Time to complete your selected tasks!",
                      );
                    }
                  : null,
              child: const Text("Trigger Test Notification"),
            ),
          ],
        ),
      ),
    );
  }
}