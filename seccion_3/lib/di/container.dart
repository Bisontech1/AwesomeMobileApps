import 'package:seccion_3/repositories/notes_repository.dart';
import 'package:seccion_3/services/auth_service.dart';
import 'package:seccion_3/services/firebase_database_service.dart';

class DIContainer {
  
  AuthService authService = AuthService();
  FirebaseDatabaseService firebaseDatabaseService = FirebaseDatabaseService();

  late NotesRepository notesRepository = NotesRepository(
    authService: authService,
    firebaseDatabaseService: firebaseDatabaseService,
  );

  DIContainer._private();

  static DIContainer instance = DIContainer._private();
}
