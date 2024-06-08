import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO : FORGOT PASSWORD VERIFICATION
      },
      child: Text(
        'ลืมรหัสผ่าน',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
