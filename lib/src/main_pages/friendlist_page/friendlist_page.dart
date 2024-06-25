import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendlistPage extends StatefulWidget {
  const FriendlistPage({super.key});

  @override
  State<FriendlistPage> createState() => _FriendlistPageState();
}

class _FriendlistPageState extends State<FriendlistPage> {
  List<String> friendlistDisplayname = [
    'Display 01',
    'Display 02',
    'Display 03',
    'Display 04',
    'Display 05',
  ];

  List<String> friendlistUsername = [
    'username01',
    'username02',
    'username03',
    'username04',
    'username05',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: _appbar(context),
      body: _body(context),
    );
  }

  AppBar _appbar(context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: const Color(0xff59A1B6),
        iconSize: 30,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'FRIENDS',
        style: GoogleFonts.sarabun(
          color: const Color(0xff59A1B6),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/friend-add');
            },
            icon: const Icon(
              Icons.person_add_outlined,
              color: Color(0xff59A1B6),
            ),
            iconSize: 30,
          ),
        )
      ],
      backgroundColor: Colors.transparent,
    );
  }

  _body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.02,
          horizontal: MediaQuery.sizeOf(context).width * 0.05,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xffB8E175),
              strokeAlign: BorderSide.strokeAlignCenter,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  color: const Color(0x95ffffff),
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xff9f9f9f),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(friendlistDisplayname[index]),
                        const SizedBox(width: 5),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * 0.45,
                          ),
                          child: Text('@${friendlistUsername[index]}'),
                        )
                      ],
                    ),
                    titleTextStyle: GoogleFonts.sarabun(color: Colors.black87),
                  ),
                );
              },
              itemCount: friendlistDisplayname.length,
            ),
          ),
        ),
      ),
    );
  }
}
