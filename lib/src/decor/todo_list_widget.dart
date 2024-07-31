import 'package:flutter/material.dart';

class TodoListWidget extends StatefulWidget {
  final List<String> todos;

  const TodoListWidget({super.key, required this.todos});

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.todos.map((todo) {
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
      ),
    );
  }
}
