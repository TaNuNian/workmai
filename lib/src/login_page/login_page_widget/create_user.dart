import 'package:flutter/material.dart';

class CreateUser extends StatelessWidget {
  const CreateUser({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: ButtonStyle(),
      child: const Text(
        'สร้างบัญชี',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
