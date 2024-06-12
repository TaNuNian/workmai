import 'package:flutter/material.dart';

class CreateAccInter extends StatefulWidget {
  const CreateAccInter({super.key});

  @override
  _CreateAccInterState createState() => _CreateAccInterState();
}

class _CreateAccInterState extends State<CreateAccInter> {

  Map<String, bool> selectedAbilities = {};
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
                    selectedAbilities: selectedAbilities,
                  ),
                  InterestCategory(
                    title: 'Category 2',
                    abilities: const ['Interest 2.1', 'Interest 2.2'],
                    selectedAbilities: selectedAbilities,
                  ),
                  InterestCategory(
                    title: 'Category 3',
                    abilities: const ['Interest 3.1', 'Interest 3.2', 'Interest 3.3'],
                    selectedAbilities: selectedAbilities,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle continue action
                  print(selectedAbilities);
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
  final Map<String, bool> selectedAbilities;

  const InterestCategory({super.key, required this.title, required this.abilities, required this.selectedAbilities});

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
          .map((ability) => InterestTile(ability: ability, selectedAbilities: selectedAbilities))
          .toList(),
    );
  }
}

class InterestTile extends StatefulWidget {
  final String ability;
  final Map<String, bool> selectedAbilities;

  const InterestTile({super.key, required this.ability, required this.selectedAbilities});

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
      value: widget.selectedAbilities[widget.ability] ?? false,
      onChanged: (bool? value) {
        setState(() {
          widget.selectedAbilities[widget.ability] = value ?? false;
        });
      },
    );
  }
}