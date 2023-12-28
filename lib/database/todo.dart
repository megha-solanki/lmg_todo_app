import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todos {
  Todos({this.title, this.descriptions, this.status});

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? descriptions;

  @HiveField(3)
  String? status;

  @HiveField(4)
  int? minutes;

  @HiveField(5)
  int? seconds;

  @HiveField(6)
  int? endMinutes;

  @HiveField(7)
  int? endSeconds;
}
