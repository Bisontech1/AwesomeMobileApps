
import 'package:firebase_database/firebase_database.dart';
import 'package:seccion_3/models/notes.dart';

class FirebaseDatabaseService {
  FirebaseDatabase db = FirebaseDatabase.instance;

  late DatabaseReference ref;

  FirebaseDatabaseService() {
    ref = db.ref("notes");
  }

  add(String userId, Note note) async {
    await ref.child(userId).child(note.id).set(
      {
        "id": note.id,
        "value": note.value,
        "dateCreated": note.dateCreated.toString(),
      },
    );
  }

  update(String userId, Note note) async {
    await ref.child(userId).child(note.id).set(
      {
        "id": note.id,
        "value": note.value,
        "dateCreated": note.dateCreated.toString(),
      },
    );
  }

  delete(String userId, Note note) async {
    await ref.child(userId).child(note.id).remove();
  }

  Future<List<Note>?> get(String userId) async {
    final result = await ref.child(userId).get();
    return result.children.map((element) {
      final map = element.value as Map;

      return Note(
        id: map["id"],
        dateCreated: DateTime.parse(map["dateCreated"]),
        value: map["value"],
      );
    }).toList();
  }
}
