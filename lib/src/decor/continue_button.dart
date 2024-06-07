import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/gradients.dart';

class ContinueButton extends StatefulWidget {
  final String? actionName;
  const ContinueButton({super.key, this.actionName});

  @override
  _ContinueButtonState createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  String get actionName => actionName;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width * 0.4;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.4,
        height: MediaQuery.sizeOf(context).height * 0.06,
        decoration: BoxDecoration(
          gradient: crossLinearGradient,
          borderRadius: BorderRadius.circular(
              (MediaQuery.sizeOf(context).height * 0.06) / 2),
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            // Removes default button background color
            shadowColor: Colors.transparent,
            // Removes shadow
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              actionName,
              style: GoogleFonts.sarabun(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
          ),
        ),
      ),
    );
  }
}
