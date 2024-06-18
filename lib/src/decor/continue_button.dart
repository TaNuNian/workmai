import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/model/profile_provider.dart';
import 'package:workmai/src/decor/gradients.dart';

class ContinueButton extends StatefulWidget {
  final String? actionName;
  final String routeName;
  final GlobalKey<FormState>? formKey;
  final bool shouldCallFunction;

  const ContinueButton({
    super.key,
    this.actionName,
    required this.routeName,
    this.formKey,
    required this.shouldCallFunction,
  });

  @override
  _ContinueButtonState createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  String get actionName => widget.actionName ?? '';
  String get routeName => widget.routeName;

  void _validateAndContinue() {
    final profileProvider = context.read<ProfileProvider>();

    if (widget.formKey?.currentState?.validate() ?? false) {
      widget.formKey?.currentState?.save();

      if ((profileProvider.profile.name?.isNotEmpty ?? false) && (profileProvider.profile.birthdate != null)) {
        widget.formKey?.currentState?.reset();
        print('Username: ${profileProvider.profile.name}');
        print('Birthday: ${profileProvider.profile.birthdate}');
        Navigator.pushNamed(context, routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('โปรดกรอกข้อมูลให้ครบถ้วน')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('โปรดกรอกข้อมูลให้ถูกต้อง')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width * 0.4;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        height: MediaQuery.sizeOf(context).height * 0.06,
        decoration: BoxDecoration(
          gradient: crossLinearGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: widget.shouldCallFunction ? _validateAndContinue : () => Navigator.pushNamed(context, widget.routeName),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              actionName,
              style: GoogleFonts.sarabun(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
