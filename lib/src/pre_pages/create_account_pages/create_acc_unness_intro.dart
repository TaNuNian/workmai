import 'package:flutter/material.dart';

class SelectAbilitiesScreen extends StatefulWidget {
  @override
  _SelectAbilitiesScreenState createState() => _SelectAbilitiesScreenState();
}

class _SelectAbilitiesScreenState extends State<SelectAbilitiesScreen> {
  Map<String, bool> selectedAbilities = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back action
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "WHAT ABILITIES DO YOU HAVE?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  AbilityCategory(
                    title: 'Category 1',
                    abilities: ['Ability 1.1', 'Ability 1.2', 'Ability 1.3'],
                    selectedAbilities: selectedAbilities,
                  ),
                  AbilityCategory(
                    title: 'Category 2',
                    abilities: ['Ability 2.1', 'Ability 2.2'],
                    selectedAbilities: selectedAbilities,
                  ),
                  AbilityCategory(
                    title: 'Category 3',
                    abilities: ['Ability 3.1', 'Ability 3.2', 'Ability 3.3'],
                    selectedAbilities: selectedAbilities,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
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
                child: Text("CONTINUE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AbilityCategory extends StatelessWidget {
  final String title;
  final List<String> abilities;
  final Map<String, bool> selectedAbilities;

  const AbilityCategory({super.key, required this.title, required this.abilities, required this.selectedAbilities});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      children: abilities
          .map((ability) => AbilityTile(ability: ability, selectedAbilities: selectedAbilities))
          .toList(),
    );
  }
}

class AbilityTile extends StatefulWidget {
  final String ability;
  final Map<String, bool> selectedAbilities;

  const AbilityTile({super.key, required this.ability, required this.selectedAbilities});

  @override
  _AbilityTileState createState() => _AbilityTileState();
}

class _AbilityTileState extends State<AbilityTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.ability,
        style: TextStyle(color: Colors.black54),
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