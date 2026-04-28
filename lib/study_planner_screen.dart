import 'package:flutter/material.dart';

class StudyPlannerHomeScreen extends StatefulWidget {
  final String username;

  const StudyPlannerHomeScreen({super.key, required this.username});

  @override
  State<StudyPlannerHomeScreen> createState() =>
      _StudyPlannerHomeScreenState();
}

class _StudyPlannerHomeScreenState extends State<StudyPlannerHomeScreen> {
  // To Do Tasks
  Map<String, String> todoTasks = {
    "Wake Up Early": "#6A3DE8",
    "Start Learning": "#47B8A6",
  };

  // Completed Tasks
  Map<String, String> completedTasks = {
    "Study 1 Hour": "#D946EF",
  };

  @override
  void initState() {
    super.initState();
  }

  // Future database/shared preferences save
  Future<void> _saveTasks() async {}

  // Convert HEX color to Flutter Color
  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse('0x$hexColor'));
  }

  Color _getTaskColor(String task, Map<String, String> taskMap) {
    String? colorHex = taskMap[task];
    if (colorHex != null) {
      try {
        return _getColorFromHex(colorHex);
      } catch (e) {
        debugPrint("Error parsing color: $e");
      }
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black, size: 30),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Menu Clicked")),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          "Welcome, ${widget.username} 👋",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 15),

          // TO DO TITLE
          const Text(
            "To Do 📝",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // TO DO TASKS
          Expanded(
            child: todoTasks.isEmpty
                ? const Center(
                    child: Text(
                      "No tasks added yet!",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    itemCount: todoTasks.length,
                    itemBuilder: (context, index) {
                      String task = todoTasks.keys.elementAt(index);
                      Color taskColor = _getTaskColor(task, todoTasks);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Dismissible(
                          key: Key(task),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              String color = todoTasks.remove(task)!;
                              completedTasks[task] = color;
                              _saveTasks();
                            });
                          },
                          background: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            alignment: Alignment.centerRight,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Complete",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.check, color: Colors.white),
                              ],
                            ),
                          ),
                          child: _buildTaskCard(task, taskColor),
                        ),
                      );
                    },
                  ),
          ),

          const SizedBox(height: 10),

          // DONE TITLE
          const Text(
            "Done ✅🎉",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          // DONE TASKS
          Expanded(
            child: completedTasks.isEmpty
                ? const Center(
                    child: Text(
                      "No completed tasks yet!",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    itemCount: completedTasks.length,
                    itemBuilder: (context, index) {
                      String task = completedTasks.keys.elementAt(index);
                      Color taskColor = _getTaskColor(task, completedTasks);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Dismissible(
                          key: Key(task),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            setState(() {
                              String color = completedTasks.remove(task)!;
                              todoTasks[task] = color;
                              _saveTasks();
                            });
                          },
                          background: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            alignment: Alignment.centerLeft,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            child: const Row(
                              children: [
                                Icon(Icons.undo, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  "Undo",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: _buildTaskCard(
                            task,
                            taskColor,
                            isCompleted: true,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      // ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade700,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add New Task Feature Coming Soon")),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // TASK CARD UI
  Widget _buildTaskCard(
    String title,
    Color color, {
    bool isCompleted = false,
  }) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 25),
        title: Center(
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        trailing: isCompleted
            ? const Icon(
                Icons.check_circle,
                color: Colors.greenAccent,
                size: 30,
              )
            : null,
      ),
    );
  }
}
