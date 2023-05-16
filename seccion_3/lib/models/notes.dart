import 'package:hive/hive.dart';

part 'notes.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  String id;
  @HiveField(1)
  String value;
  @HiveField(2)
  DateTime dateCreated;

  Note({
    required this.id,
    required this.value,
    required this.dateCreated,
  });
}
