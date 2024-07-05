import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Milestones extends StatefulWidget {
  const Milestones({super.key});

  @override
  _MilestonesState createState() => _MilestonesState();
}

class _MilestonesState extends State<Milestones> {
  int? _selectedValue = 1;
  late final ScrollController _scrollController;

  final List<String> _point = [
    'Point 1',
    'Markdown',
    'Deadline',
    'Hello!?',
  ];

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: const Color(0xffffffff),
            child: ListTile(
              title: Text(
                _point[index],
                style: GoogleFonts.raleway(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        );
      },
      itemCount: _point.length,
    );
  }
}
// <Widget>[
//         ExpansionTile(
//           title: Text('Option 1'),
//           children: <Widget>[
//             Container(
//               color: Colors.lightGreenAccent,
//               padding: const EdgeInsets.all(16.0),
//               child: Text('Expanded content for Option 1'),
//             ),
//           ],
//         ),
//         ExpansionTile(
//           title: Text('Option 2'),
//           children: <Widget>[
//             Container(
//               color: Colors.lightGreenAccent,
//               padding: const EdgeInsets.all(16.0),
//               child: Text('Expanded content for Option 2'),
//             ),
//           ],
//         ),
//         ExpansionTile(
//           title: Text('Option 3'),
//           children: <Widget>[
//             Container(
//               color: Colors.lightGreenAccent,
//               padding: const EdgeInsets.all(16.0),
//               child: Text('Expanded content for Option 3'),
//             ),
//           ],
//         ),
//       ],
