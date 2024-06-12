import 'package:flutter/material.dart';

class SelectAbilitiesScreen extends StatefulWidget {
  const SelectAbilitiesScreen({super.key});

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
                  SkillCategory(
                    title: 'Category 1',
                    abilities: ['Skill 1.1', 'Skill 1.2', 'Skill 1.3'],
                    selectedAbilities: selectedAbilities,
                  ),
                  SkillCategory(
                    title: 'Category 2',
                    abilities: ['Skill 2.1', 'Skill 2.2'],
                    selectedAbilities: selectedAbilities,
                  ),
                  SkillCategory(
                    title: 'Category 3',
                    abilities: ['Skill 3.1', 'Skill 3.2', 'Skill 3.3'],
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

class SkillCategory extends StatelessWidget {
  final String title;
  final List<String> abilities;
  final Map<String, bool> selectedAbilities;

  const SkillCategory({super.key, required this.title, required this.abilities, required this.selectedAbilities});

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
          .map((ability) => SkillTile(ability: ability, selectedAbilities: selectedAbilities))
          .toList(),
    );
  }
}

class SkillTile extends StatefulWidget {
  final String ability;
  final Map<String, bool> selectedAbilities;

  const SkillTile({super.key, required this.ability, required this.selectedAbilities});

  @override
  _SkillTileState createState() => _SkillTileState();
}

class _SkillTileState extends State<SkillTile> {
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