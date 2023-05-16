import 'package:flutter/material.dart';
import 'package:seccion_1/di/container.dart';
import 'package:seccion_1/models/notes.dart';
import 'package:seccion_1/repositories/notes_repository.dart';
import 'package:seccion_1/screens/add_notes.dart';
import 'package:seccion_1/screens/update_notes.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final NotesRepository notesRepository = DIContainer.instance.notesRepository;
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  getNotes() {
    setState(() {
      notes = notesRepository.notes;
    });
  }

  addNote(Note note) {
    notesRepository.add(note);
    getNotes();
  }

  updateNote(Note note) {
    notesRepository.update(note);
    getNotes();
  }

  removeNote(Note note) {
    notesRepository.delete(note);
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Notas"),
      ),
      body: Builder(
        builder: (context) {
          if (notes.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.help,
                    size: 40,
                    color: Colors.grey,
                  ),
                  Text("No existen notas"),
                ],
              ),
            );
          }

          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              var item = notes[index];
              return Dismissible(
                key: Key(item.id),
                onDismissed: (direction) {
                  removeNote(item);
                },
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateNotesScreen(
                          note: item,
                          onNoteUpdated: (note) {
                            updateNote(note);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                  leading: const Icon(Icons.note_alt_outlined),
                  title: Text(item.value),
                  subtitle: Text(
                      "${item.dateCreated.day}/${item.dateCreated.month}/${item.dateCreated.year}"),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotesScreen(
                onNoteAdded: (note) {
                  addNote(note);
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
