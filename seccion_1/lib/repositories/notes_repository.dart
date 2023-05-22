import 'package:seccion_1/models/notes.dart';

class NotesRepository {
  final List<Note> notes = [];

  NotesRepository();

  add(Note note) {
    notes.add(note);
  }

  delete(Note note) {
    notes.removeWhere((element) => element.id == note.id);
  }

  update(Note note) {
    var index = notes.indexWhere((element) => element.id == note.id);
    if (index == -1) return;
    notes[index] = note;
  }
}
