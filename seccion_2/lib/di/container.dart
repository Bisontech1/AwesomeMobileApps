import 'package:seccion_2/repositories/notes_repository.dart';

class DIContainer {
  NotesRepository notesRepository = NotesRepository();

  DIContainer._private();

  static DIContainer instance = DIContainer._private();

}
