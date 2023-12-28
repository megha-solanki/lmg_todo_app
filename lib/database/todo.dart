import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todos {
  Todos(
      {this.key,
      this.title,
      this.descriptions,
      this.status,
      this.todoMinutes,
      this.todoSeconds});

  @HiveField(0)
  String? key;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? descriptions;

  @HiveField(3)
  String? status;

  @HiveField(4)
  int? todoMinutes;

  @HiveField(5)
  int? todoSeconds;

  @HiveField(6)
  int? endMinutes;

  @HiveField(7)
  int? endSeconds;
}
