import 'package:flutter/material.dart';

class TagList extends StatelessWidget {
  final Map<String, List<String>> tags;
  final Map<String, bool> selectedInterest;

  TagList({required this.tags, required this.selectedInterest});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: tags.keys.map((category) {
        return ExpansionTile(
          title: Text(
            category,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          children: tags[category]!
              .map((ability) => CheckboxListTile(
            title: Text(ability),
            value: selectedInterest[ability] ?? false,
            onChanged: (bool? value) {
              selectedInterest[ability] = value ?? false;
            },
          ))
              .toList(),
        );
      }).toList(),
    );
  }
}
