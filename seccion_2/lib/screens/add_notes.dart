import 'package:flutter/material.dart';
import 'package:seccion_2/models/notes.dart';

class AddNotesScreen extends StatefulWidget {
  final Function(Note note) onNoteAdded;

  const AddNotesScreen({
    super.key,
    required this.onNoteAdded,
  });

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  String? value;

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
                this.value = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (value == null) return;
                final dateCreated = DateTime.now();
                widget.onNoteAdded(Note(
                  id: dateCreated.millisecondsSinceEpoch.toString(),
                  value: value!,
                  dateCreated: dateCreated,
                ));
              },
              child: const Text("Agregar Nota"),
            )
          ],
        ),
      ),
    );
  }
}
