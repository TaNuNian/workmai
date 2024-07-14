import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NewsTile extends StatelessWidget {
  final String newsTitle;
  final String detail;
  final bool isOnsite;
  final Timestamp? endDate;
  final String? imageUrl;
  final double? price;

  const NewsTile({
    super.key,
    required this.newsTitle,
    required this.detail,
    required this.isOnsite,
    this.endDate,
    this.imageUrl,
    this.price,
  });

  String formatEndDate() {
    if (endDate == null) return '';
    final endDateTime = endDate!.toDate();
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm a');
    return formatter.format(endDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color(0xffEFFED5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            if (imageUrl != null && imageUrl!.isNotEmpty)
              Container(
                width: 90,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(
                      newsTitle,
                      style: GoogleFonts.raleway(
                        color: const Color(0xff327B90),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      detail,
                      style: GoogleFonts.raleway(
                        color: const Color(0xff55B18D),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xff327B90),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isOnsite ? 'ONSITE' : 'ONLINE',
                            style: GoogleFonts.raleway(
                              color: const Color(0xffFFFFFF),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: price == null ? Colors.green : const Color(0xff327B90),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            price == null ? 'FREE!!!' : 'Price: ${price!.toStringAsFixed(2)} บาท',
                            style: GoogleFonts.raleway(
                              color: const Color(0xffFFFFFF),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (endDate != null)
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        'หมดเขตลงทะเบียน: ${formatEndDate()}',
                        style: GoogleFonts.raleway(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
