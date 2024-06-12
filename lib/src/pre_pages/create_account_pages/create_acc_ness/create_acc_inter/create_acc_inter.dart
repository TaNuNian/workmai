import 'package:flutter/material.dart';

class CreateAccInter extends StatefulWidget {
  const CreateAccInter({super.key});

  @override
  _CreateAccInterState createState() => _CreateAccInterState();
}

class _CreateAccInterState extends State<CreateAccInter> {

  Map<String, bool> selectedInterest = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "WHAT ABILITIES DO YOU HAVE?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  InterestCategory(
                    title: 'Category 1',
                    abilities: const ['Interest 1.1', 'Interest 1.2', 'Interest 1.3'],
                    selectedInterest: selectedInterest,
                  ),
                  InterestCategory(
                    title: 'Category 2',
                    abilities: const ['Interest 2.1', 'Interest 2.2'],
                    selectedInterest: selectedInterest,
                  ),
                  InterestCategory(
                    title: 'Category 3',
                    abilities: const ['Interest 3.1', 'Interest 3.2', 'Interest 3.3'],
                    selectedInterest: selectedInterest,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create-acc-unness-intro');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("CONTINUE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InterestCategory extends StatelessWidget {
  final String title;
  final List<String> abilities;
  final Map<String, bool> selectedInterest;

  const InterestCategory({super.key, required this.title, required this.abilities, required this.selectedInterest});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      children: abilities
          .map((ability) => InterestTile(ability: ability, selectedInterest: selectedInterest))
          .toList(),
    );
  }
}

class InterestTile extends StatefulWidget {
  final String ability;
  final Map<String, bool> selectedInterest;

  const InterestTile({super.key, required this.ability, required this.selectedInterest});

  @override
  _InterestTileState createState() => _InterestTileState();
}

class _InterestTileState extends State<InterestTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.ability,
        style: const TextStyle(color: Colors.black54),
      ),
      value: widget.selectedInterest[widget.ability] ?? false,
      onChanged: (bool? value) {
        setState(() {
          widget.selectedInterest[widget.ability] = value ?? false;
        });
      },
    );
  }
}