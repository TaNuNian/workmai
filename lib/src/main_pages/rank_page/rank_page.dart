import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workmai/methods/cloud_firestore/rank.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final RankService _rankService = RankService();

  double now = 0;
  double max = 60; // Initial max value for Beginner
  String rankName = 'Unranked';
  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    _fetchRankData();
    _fetchRankHistory();
  }

  Future<void> _fetchRankData() async {
    if (user == null) return;

    DocumentSnapshot rankSnapshot = await _rankService.getUserRank(user!.uid);
    if (rankSnapshot.exists) {
      Map<String, dynamic> rankData = rankSnapshot.data() as Map<String, dynamic>;
      setState(() {
        rankName = rankData['rankName'] ?? 'Unranked';
        now = rankData['points'].toDouble();
        max = _getMaxPointsForRank(rankName);
      });
    }
  }

  double _getMaxPointsForRank(String rank) {
    switch (rank) {
      case 'Beginner':
        return 350;
      case 'Intermediate':
        return 900;
      case 'Expert':
        return 1;
      default:
        return 60;
    }
  }

  Future<void> _fetchRankHistory() async {
    if (user == null) return;

    QuerySnapshot historySnapshot = await _rankService.getUserRankHistory(user!.uid);
    List<Map<String, dynamic>> historyData = historySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    setState(() {
      history = historyData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: body(context),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      leading: const BackButton(
        color: Color(0xffFFFFFF),
      ),
      title: Text(
        'RANK',
        style: GoogleFonts.raleway(
          color: const Color(0xffFFFFFF),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xff327B90),
    );
  }

  Widget body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            _levelGauge(context),
            const SizedBox(height: 24),
            _history(context),
          ],
        ),
      ),
    );
  }

  Widget _levelGauge(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffEFFED5),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.military_tech_outlined,
                      color: Color(0xff327B90),
                      size: 32,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      rankName,
                      style: GoogleFonts.raleway(
                        color: const Color(0xff327B90),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    minHeight: 20,
                    value: now / max,
                    backgroundColor: const Color(0xffAEAEAE),
                    color: const Color(0xff327B90),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Points: ${now.toStringAsFixed(1)} / ${max.toStringAsFixed(1)}',
                  style: GoogleFonts.raleway(
                    color: const Color(0xff327B90),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _history(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffEFFED5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.history,
                        color: Color(0xff327B90),
                        size: 32,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'History',
                        style: GoogleFonts.raleway(
                          color: const Color(0xff327B90),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _historylist(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _historylist(BuildContext context) {
    return Expanded(
      flex: 9,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 4, right: 4),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index];
              final reason = item['reason'] ?? 'No reason';
              final scoring = item['change'] ?? 0;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reason,
                      style: GoogleFonts.raleway(
                        color: scoring < 0
                            ? const Color(0xffed0b0b)
                            : const Color(0xff36f45d),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '$scoring',
                      style: GoogleFonts.raleway(
                        color: scoring < 0
                            ? const Color(0xffed0b0b)
                            : const Color(0xff36f45d),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
