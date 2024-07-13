import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appbar(context),
      body: _body(context),
    );
  }

  _appbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'MY REVIEWS',
        style: GoogleFonts.raleway(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xff327B90),
      elevation: 0,
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfileSection(context),
          _buildRatingSection(context),
          _buildHistorySection(context),
        ],
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      color: const Color(0xff327B90),
      width: MediaQuery.sizeOf(context).width,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSection(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '3.45',
              style: GoogleFonts.inter(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: const Color(0xff327B90),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      Icon(
                        i < 3 ? Icons.star : Icons.star_border,
                        color: const Color(0xffA1E8AF),
                        size: 24,
                      ),
                  ],
                ),
                Text(
                  'From 10 reviews',
                  style: GoogleFonts.raleway(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        )
        // Column(
        //   children: [

        //     Row(
        //
        //       children: [

        //       ],
        //     ),
        //   ],
        // ),
        );
  }

  Widget _buildHistorySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'History',
                style: GoogleFonts.raleway(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff327B90),
                ),
              ),
              Row(
                children: [
                  Text(
                    'See all',
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      color: const Color(0xff327B90),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xff327B90),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: MediaQuery.sizeOf(context).height *
                0.4, // Adjust height as needed
            color: const Color(0xffEFFED5),
            child: ListView.builder(
              itemCount: 5, // Number of history items
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Review $index'),
                  subtitle: const Text('Review details here'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
