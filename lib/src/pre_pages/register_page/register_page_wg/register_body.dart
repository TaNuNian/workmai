import 'package:flutter/material.dart';
import 'register_children_wg.dart';
import 'register_header_text.dart';

class RegisterChildren extends StatelessWidget {
  const RegisterChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: registerText.length,
      itemBuilder: (context, index) {
        return RegisterChildrenWg(
            child: registerText[index]
        );
      },
    );
  }
}