
import 'package:firebase_database/firebase_database.dart';
import 'package:seccion_3/models/notes.dart';

class FirebaseDatabaseService {
  FirebaseDatabase db;

  late DatabaseReference _ref;

  FirebaseDatabaseService({
    required this.db,
  }) {
    _ref = db.ref("notes");
  }

  add(String userId, Note note) async {
    await _ref.child(userId).child(note.id).set(
      {
        "id": note.id,
        "value": note.value,
        "dateCreated": note.dateCreated.toString(),
      },
    );
  }

  update(String userId, Note note) async {
    await _ref.child(userId).child(note.id).set(
      {
        "id": note.id,
        "value": note.value,
        "dateCreated": note.dateCreated.toString(),
      },
    );
  }

  remove(String userId, Note note) async {
    await _ref.child(userId).child(note.id).remove();
  }

  Future<List<Note>?> get(String userId) async {
    var result = await _ref.child(userId).get();
    return result.children.map((e) {
      var map = e.value as Map;
      return Note(
        id: map["id"],
        value: map["value"],
        dateCreated: DateTime.parse(map["dateCreated"]),
      );
    }).toList();
  }
}
