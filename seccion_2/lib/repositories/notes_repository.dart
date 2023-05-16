import 'package:hive_flutter/hive_flutter.dart';
import 'package:seccion_2/models/notes.dart';

class NotesRepository {
  late Box<Note> _notesBox;

  List<Note> get notes => _notesBox.values.toList();

  NotesRepository();

  init() async {
    _notesBox = await Hive.openBox<Note>("notes");
  }

  add(Note note) {
    _notesBox.put(note.id, note);
  }

  delete(Note note) {
    _notesBox.delete(note.id);
  }

  update(Note note) {
    _notesBox.put(note.id, note);
  }
}
