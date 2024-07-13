import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userProfile;
  double? rating;
  int? reviewCount;
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
    fetchUserReviews();
  }

  Future<void> fetchUserProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        userProfile = userDoc.data();
      });
    }
  }

  Future<void> fetchUserReviews() async {
    final user = _auth.currentUser;
    if (user != null) {
      final reviewDoc = await _firestore.collection('reviews').doc(user.uid).get();
      if (reviewDoc.exists) {
        final reviewData = reviewDoc.data() as Map<String, dynamic>;
        setState(() {
          rating = (reviewData['totalRating'] ?? 0.0).toDouble();
          reviewCount = (reviewData['reviewCount'] ?? 0).toInt();
        });

        final commentsCollection = await reviewDoc.reference.collection('comments').get();
        setState(() {
          comments = commentsCollection.docs.map((doc) {
            return {
              'comment': doc['comment'],
              'timestamp': doc['timestamp'],
            };
          }).toList();
        });

        // Debug print statements
        print('User Rating: $rating');
        print('Review Count: $reviewCount');
        print('Comments: $comments');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appbar(context),
      body: _body(context),
    );
  }

  AppBar _appbar(BuildContext context) {
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
    String displayName = 'Loading...';
    if (userProfile != null) {
      if (userProfile!['profile']['display_name'] != '') {
        displayName = userProfile!['profile']['display_name'];
      } else {
        displayName = 'Display Name';
      }
    }
    return Container(
      color: const Color(0xff327B90),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              backgroundImage: userProfile != null && userProfile!['profilePicture'] != null
                  ? NetworkImage(userProfile!['profilePicture'])
                  : null,
              child: userProfile == null || userProfile!['profilePicture'] == null
                  ? const Icon(Icons.person, size: 60, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 20),
            Text(
              displayName,
              style: GoogleFonts.raleway(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSection(BuildContext context) {
    final ratingValue = rating ?? 0.0;
    final reviewCountValue = reviewCount ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ratingValue.toStringAsFixed(2),
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
                children: List.generate(5, (index) {
                  return Icon(
                    index < ratingValue.round() ? Icons.star : Icons.star_border,
                    color: const Color(0xffA1E8AF),
                    size: 24,
                  );
                }),
              ),
              Text(
                'From $reviewCountValue reviews',
                style: GoogleFonts.raleway(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
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
            height: MediaQuery.of(context).size.height * 0.4, // Adjust height as needed
            color: const Color(0xffEFFED5),
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  title: Text(comment['comment'] ?? 'No comment'),
                  subtitle: Text(comment['timestamp'] != null
                      ? (comment['timestamp'] as Timestamp).toDate().toString()
                      : 'No date'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
