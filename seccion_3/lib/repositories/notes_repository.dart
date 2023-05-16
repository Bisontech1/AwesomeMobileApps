import 'package:hive_flutter/hive_flutter.dart';
import 'package:seccion_3/models/notes.dart';
import 'package:seccion_3/services/auth_service.dart';
import 'package:seccion_3/services/firebase_database_service.dart';

class NotesRepository {
  late Box<Note> _notesBox;

  List<Note> get notes => _notesBox.values.toList();

  AuthService authService;
  FirebaseDatabaseService firebaseDatabaseService;

  NotesRepository({
    required this.authService,
    required this.firebaseDatabaseService,
  });

  init() async {
    _notesBox = await Hive.openBox<Note>("notes");
  }

  loadCloudNotes() async {
    if (!authService.isSignedIn) return;

    var cloudNotes =
        await firebaseDatabaseService.get(authService.currentUser!.uid) ?? [];

    for (var note in cloudNotes) {
      await add(note);
    }
  }

  saveNotesToCloud() async {
    if (!authService.isSignedIn) return;

    for (var note in notes) {
      await firebaseDatabaseService.add(authService.currentUser!.uid, note);
    }
  }

  add(Note note) async {
    await _notesBox.put(note.id, note);

    if (authService.isSignedIn) {
      await firebaseDatabaseService.add(authService.currentUser!.uid, note);
    }

  }

  delete(Note note) async {
    await _notesBox.delete(note.id);

    if (authService.isSignedIn) {
      await firebaseDatabaseService.remove(authService.currentUser!.uid, note);
    }
  }

  update(Note note) async {
    await _notesBox.put(note.id, note);
    
    if (authService.isSignedIn) {
      await firebaseDatabaseService.update(authService.currentUser!.uid, note);
    }
  }
}
