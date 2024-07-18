import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

IconData getRankIcon(String rank) {
  switch (rank) {
    case 'Beginner':
      return Icons.military_tech_outlined;
    case 'Intermediate':
      return Icons.military_tech_outlined;
    case 'Expert':
      return Icons.military_tech_outlined;
    default:
      return Icons.military_tech_outlined; // Default icon
  }
}

Color getRankColor(String rank) {
  switch (rank) {
    case 'Beginner':
      return Color(0xFFCD7F32); // Bronze color
    case 'Intermediate':
      return Color(0xFFC0C0C0); // Silver color
    case 'Expert':
      return Color(0xFFFFD700); // Gold color
    default:
      return Color(0xFF00897B); // Default color for no rank
  }
}

String getRankName(String rank) {
  switch (rank) {
    case 'Beginner':
      return 'Beginner';
    case 'Intermediate':
      return 'Intermediate';
    case 'Expert':
      return 'Expert';
    default:
      return 'No Rank';
  }
}