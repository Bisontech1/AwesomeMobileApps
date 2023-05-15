import 'package:flutter/material.dart';

class AddNotesScreen extends StatefulWidget {
  final Function(String value) onNoteAdded;

  const AddNotesScreen({
    super.key,
    required this.onNoteAdded,
  });

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {

  String? note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Añadir nota"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nota",
              ),
              onChanged: (value) {
                note = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if(note == null) return;
                widget.onNoteAdded(note!);
              },
              child: Text("Agregar Nota"),
            )
          ],
        ),
      ),
    );
  }
}
