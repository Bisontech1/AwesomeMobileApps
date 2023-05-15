import 'package:seccion_2/models/notes.dart';

class NotesRepository {
  final List<Note> _notes = [];

  List<Note> get notes => _notes;

  NotesRepository();

  add(Note note) {
    _notes.add(note);
  }

  delete(Note note) {
    _notes.removeWhere((element) => element.id == note.id);
  }

  update(Note note) {
    var index = _notes.indexWhere((element) => element.id == note.id);
    if (index == -1) return;
    _notes[index] = note;
  }
}
