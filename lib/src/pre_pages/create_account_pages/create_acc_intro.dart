import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/gradients.dart';

class CreateAccIntro extends StatelessWidget {
  const CreateAccIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                child: Container(
                  decoration: const BoxDecoration(gradient: mainLinearGradient),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'มาสร้างโปรไฟล์\nของคุณกัน!',
                        style: GoogleFonts.sarabun(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        textScaler: TextScaler.linear(1),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/create-acc-ness');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
