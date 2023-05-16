import 'package:flutter/material.dart';
import 'package:seccion_2/models/notes.dart';

class UpdateNotesScreen extends StatefulWidget {
  final Note note;
  final Function(Note note) onNoteUpdated;

  const UpdateNotesScreen({
    super.key,
    required this.note,
    required this.onNoteUpdated,
  });

  @override
  State<UpdateNotesScreen> createState() => _UpdateNotesScreenState();
}

class _UpdateNotesScreenState extends State<UpdateNotesScreen> {
  final TextEditingController inputController = TextEditingController();
  late Note note;

  @override
  void initState() {
    super.initState();
    note = widget.note;
    inputController.value = TextEditingValue(text: note.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Actualizar nota"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: inputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nota",
              ),
              onChanged: (value) {
                note.value = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                widget.onNoteUpdated(note);
              },
              child: Text("Actualizar Nota"),
            )
          ],
        ),
      ),
    );
  }
}
