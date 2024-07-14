import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<String> settingList = [
    'Setting 01',
    'Setting 02',
    'Setting 03',
    'Setting 04',
    // 'Log Out',
    // 'Contact Us'
  ];

  final List<Icon> settingIconList = const [
    Icon(Icons.settings_suggest),
    Icon(Icons.settings_suggest),
    Icon(Icons.settings_suggest),
    Icon(Icons.settings_suggest),
    // Icon(Icons.logout_outlined),
    // Icon(Icons.contact_phone),
    // 'Log Out',
    // 'Contact Us'
  ];

  final List<Widget> settingWidget = const [
    Scaffold(body: Center(child: Text('01'))),
    Scaffold(body: Center(child: Text('02'))),
    Scaffold(body: Center(child: Text('03'))),
    Scaffold(body: Center(child: Text('04'))),
    // Scaffold(body: Center(child: Text('Log Out'))),
    // Scaffold(body: Center(child: Text('Contact Us'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _body(context),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff327B90),
      leading: const BackButton(
        color: Color(0xffFFFFFF),
      ),
      title: Text(
        'Settings',
        style: GoogleFonts.raleway(
            color: const Color(0xffFFFFFF),
            fontSize: 28,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _list(context),
            ),
            _listBottom(context),
          ],
        ),
      ),
    );
  }

  Widget _listBottom(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print('Log Out'); // TODO
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xffFF0000),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                'Log Out',
                style: GoogleFonts.raleway(
                  color: const Color(0xffFFFFFF),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            return print('Contact Us'); // TODO
          },
          child: Text(
            'Contact Us',
            style: GoogleFonts.raleway(
              color: Colors.orange,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  _list(BuildContext context) {
    return ListView.builder(
      itemCount: settingList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => settingWidget[index],
              ),
            );
          },
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Icon(settingIconList[index]),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          settingList[index],
                          style: GoogleFonts.raleway(
                            color: Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(color: Color(0xffCCCCCC), thickness: 2)
            ],
          ),
        );
      },
    );
  }
}
