import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/gradients.dart';

class CreateAccountPages extends StatelessWidget {
  const CreateAccountPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(gradient: mainLinearGradient),
                child: Center(
                    child: Text(
                  'มาสร้างโปรไฟล์ของคุณกัน!',
                  style: GoogleFonts.sarabun(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
