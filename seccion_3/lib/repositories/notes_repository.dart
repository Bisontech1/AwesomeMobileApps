import 'package:hive_flutter/hive_flutter.dart';
import 'package:seccion_3/models/notes.dart';
import 'package:seccion_3/services/auth_service.dart';
import 'package:seccion_3/services/firebase_database_service.dart';

class NotesRepository {
  late Box<Note> notesBox;

  List<Note> get notes => notesBox.values.toList();

  AuthService authService;
  FirebaseDatabaseService firebaseDatabaseService;

  NotesRepository({
    required this.authService,
    required this.firebaseDatabaseService,
  });

  init() async {
    notesBox = await Hive.openBox("notes");
  }

  loadCloudNotes() async {
    if (!authService.isSignedIn) return;

    var cloudNotes =
        await firebaseDatabaseService.get(authService.currentUser!.uid) ?? [];

    for (var note in cloudNotes) {
      await add(note);
    }
  }

  saveCloudNotes() async {
    if (!authService.isSignedIn) return;

    for (var note in notes) {
      await firebaseDatabaseService.add(authService.currentUser!.uid, note);
    }
  }

  add(Note note) async {
    await notesBox.put(note.id, note);

    if (authService.isSignedIn) {
      await firebaseDatabaseService.add(authService.currentUser!.uid, note);
    }
  }

  delete(Note note) async {
    await notesBox.delete(note.id);

    if (authService.isSignedIn) {
      await firebaseDatabaseService.delete(authService.currentUser!.uid, note);
    }
  }

  update(Note note) async {
    await notesBox.put(note.id, note);

    if (authService.isSignedIn) {
      await firebaseDatabaseService.update(authService.currentUser!.uid, note);
    }
  }
}
