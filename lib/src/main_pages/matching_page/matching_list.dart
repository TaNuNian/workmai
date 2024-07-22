import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/model/matching_user_provider.dart';

class MatchingList extends StatefulWidget {
  const MatchingList({super.key});

  @override
  State<MatchingList> createState() => _MatchingListState();
}

class _MatchingListState extends State<MatchingList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'YOUR SELECTED MATCHING',
        style: GoogleFonts.raleway(
          color: const Color(0xff327B90),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: BackButton(
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Consumer<MatchingUserProvider>(
      builder: (context, userProvider, child) {
        return ListView.builder(
          itemCount: userProvider.uids.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(userProvider.uids[index]),
            );
          },
        );
      },
    );
  }
}
