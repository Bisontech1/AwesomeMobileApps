import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:seccion_2/models/notes.dart';
import 'package:seccion_2/screens/notes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
    
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),

        useMaterial3: true,
      ),
      home: const NotesScreen(),
    );
  }
}
