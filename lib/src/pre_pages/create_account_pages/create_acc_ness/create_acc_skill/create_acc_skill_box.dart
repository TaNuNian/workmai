import 'package:flutter/material.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/create_acc_skill/create_acc_skill_provider.dart';

class CreateAccSkillBox extends StatelessWidget {
  const CreateAccSkillBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: CreateAccSkillProvider(),
      ),
    );
  }
}
