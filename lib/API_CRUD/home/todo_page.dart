import 'package:consuming_rest_api/API_CRUD/screens/add_page.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addNote,
        label: const Text("Add Note"),
      ),
    );
  }

  void addNote() {
    final route = MaterialPageRoute(builder: (context) {
      return const AddPage();
    });
    Navigator.push(context, route);
  }
}
