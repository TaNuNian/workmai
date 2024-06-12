import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/custom_appbar/custom_appbar.dart';
import 'package:workmai/src/decor/continue_button.dart';
import 'package:workmai/src/decor/gradients.dart';
import 'package:workmai/src/decor/padding.dart';

class CreateAccUnnessIntro extends StatelessWidget {
  const CreateAccUnnessIntro({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(gradient: mainLinearGradient),
            ),
            Padding(
              padding: bodyPadding(context),
              child: Container(
                color: Colors.black,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: CustomAppbar(
                        appbarColor: Colors.transparent,
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Text(
                        'Please share us the other details about yourself?\n\nFor stepping up your experiences!.',
                        style: GoogleFonts.sarabun(
                          color: const Color(0xffffffff),
                          shadows: [
                            const Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 5,
                              color: Color.fromRGBO(150, 150, 150, 1),
                            ),
                          ],
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Flexible(
                      child: ContinueButton(
                        routeName: '/',
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
