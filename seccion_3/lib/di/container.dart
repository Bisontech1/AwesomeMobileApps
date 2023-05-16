import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:seccion_3/repositories/notes_repository.dart';
import 'package:seccion_3/services/auth_service.dart';
import 'package:seccion_3/services/firebase_database_service.dart';

class DIContainer {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  late final AuthService authService = AuthService(
    auth: _firebaseAuth,
    googleSignIn: _googleSignIn,
  );
  
  late final FirebaseDatabaseService _firebaseDatabaseService =
      FirebaseDatabaseService(db: _firebaseDatabase);

  late NotesRepository notesRepository = NotesRepository(
    authService: authService,
    firebaseDatabaseService: _firebaseDatabaseService,
  );

  DIContainer._private();

  static final DIContainer _instance = DIContainer._private();

  static DIContainer get instance => _instance;
}
