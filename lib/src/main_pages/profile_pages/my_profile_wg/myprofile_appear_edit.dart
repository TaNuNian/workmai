import 'package:flutter/material.dart';

class MyprofileAppearEdit extends StatelessWidget {
  const MyprofileAppearEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height * 0.1,
      ),
      child: SizedBox(
        width: 55,
        height: 55,
        child: GestureDetector(
          onTap: () {
            // TODO: EDIT PROFILE PAGE
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xff69B5CB),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20)),
            child: const Icon(
              Icons.edit,
              color: Color(0xffffffff),
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
