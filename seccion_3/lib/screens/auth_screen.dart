import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:seccion_3/di/container.dart';
import 'package:seccion_3/repositories/notes_repository.dart';
import 'package:seccion_3/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  final VoidCallback signInChanged;
  final VoidCallback notesLoaded;

  const AuthScreen({
    super.key,
    required this.signInChanged,
    required this.notesLoaded,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = DIContainer.instance.authService;
  final NotesRepository _notesRepository = DIContainer.instance.notesRepository;
  var isLoading = false;

  User? currentUser;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentUser = _authService.currentUser;
    });
  }

  signIn() async {
    setState(() {
      isLoading = true;
    });

    var user = await _authService.signInWithGoogle();
    widget.signInChanged();

    setState(() {
      currentUser = user;
      isLoading = false;
    });
  }

  signOut() async {
    setState(() {
      isLoading = true;
    });

    await _authService.signOut();
    widget.signInChanged();

    setState(() {
      currentUser = null;
      isLoading = false;
    });
  }

  loadNotes(BuildContext context) async {
    await _notesRepository.loadCloudNotes();
    widget.notesLoaded();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Notas cargadas exitosamente")),
      );
    }
  }

  saveNotes(BuildContext context) async {
    await _notesRepository.saveCloudNotes();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Notas guardadas en la nube")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Iniciar Sesión"),
      ),
      body: Builder(
        builder: (context) {
          if (isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            );
          }

          if (currentUser == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInButton(
                    Buttons.Google,
                    onPressed: () {
                      signIn();
                    },
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: Image.network(
                      currentUser?.photoURL ?? "",
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  currentUser?.displayName ?? "",
                  style: const TextStyle(fontSize: 23),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    loadNotes(context);
                  },
                  child: const Text("Cargar Notas"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    saveNotes(context);
                  },
                  child: const Text("Guardar Notas"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    signOut();
                  },
                  child: const Text("Cerrar Sesión"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
