import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/textfield_decor.dart';

class SocialContact extends StatefulWidget {
  final bool? isEdit;

  const SocialContact({
    super.key,
    this.isEdit,
  });

  @override
  State<SocialContact> createState() => _SocialContactState();
}

class _SocialContactState extends State<SocialContact> {
  late List<TextEditingController> _controllers;
  final List<String> contactList = ['Email', 'Instagram', 'Facebook'];
  late int itemCount = contactList.length;


  @override
  void initState() {
    super.initState();
    _controllers = List.generate(itemCount, (index) => TextEditingController());

    if (widget.isEdit ?? false == true) {
      for (int i = 0; i < itemCount; i++) {
        _controllers[i].text = contactList[i]; // Set initial text if needed
      }
    }
    else {
      setState(() {});
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dimension = 100;
    bool isEdit = widget.isEdit ?? false;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
        horizontal: MediaQuery.of(context).size.width * 0.02,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SOCIAL',
                  style: GoogleFonts.raleway(
                    color: const Color(0xff327B90),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: dimension * itemCount,
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      const Icon(Icons.account_circle_outlined),
                      const SizedBox(width: 8),
                      if (isEdit)
                        Expanded(
                          child: TextField(
                            controller: _controllers[index],
                            decoration: textfieldDec('Your social contact'),
                          ),
                        )
                      else
                        Expanded(
                          child: Text(
                            contactList[index],
                            style: GoogleFonts.raleway(
                              color: const Color(0xff327B90),
                              fontSize: 18,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
