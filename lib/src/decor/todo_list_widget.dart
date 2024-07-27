import 'package:flutter/material.dart';

class TodoListWidget extends StatelessWidget {
  final List<String> todos;

  const TodoListWidget({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: todos.map((todo) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              todo,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
