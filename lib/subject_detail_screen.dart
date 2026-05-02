import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubjectDetailScreen extends StatefulWidget {
  const SubjectDetailScreen({super.key});

  @override
  State<SubjectDetailScreen> createState() =>
      _SubjectDetailScreenState();
}

class _SubjectDetailScreenState
    extends State<SubjectDetailScreen> {
  List<dynamic> apiData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudyResources();
  }

  // GET API DATA
  Future<void> fetchStudyResources() async {
    final url = Uri.parse(
      'https://jsonplaceholder.typicode.com/posts',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          apiData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Resources"),
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: apiData.length > 20
                  ? 20
                  : apiData.length,
              itemBuilder: (context, index) {
                final item = apiData[index];

                return Card(
                  margin:
                      const EdgeInsets.all(10),
                  elevation: 4,
                  child: ListTile(
                    leading: const Icon(
                      Icons.menu_book,
                      color: Colors.deepPurple,
                    ),
                    title: Text(
                      item['title'],
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      item['body'],
                      maxLines: 3,
                      overflow:
                          TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                );
              },
            ),
    );
  }
}