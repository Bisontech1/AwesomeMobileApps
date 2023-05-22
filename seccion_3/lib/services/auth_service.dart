import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  bool get isSignedIn => auth.currentUser != null;
  User? get currentUser => auth.currentUser;

  Future<User?> signInWithGoogle() async {
    final result = await googleSignIn.signIn();

    final googleAuthResult = await result?.authentication;

    if (googleAuthResult == null) return null;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuthResult.accessToken,
      idToken: googleAuthResult.idToken,
    );

    final authResult = await auth.signInWithCredential(credential);

    return authResult.user;
  }

  signOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }
}
