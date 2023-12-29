// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodosAdapter extends TypeAdapter<Todos> {
  @override
  final int typeId = 1;

  @override
  Todos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todos(
      key: fields[0] as String?,
      title: fields[1] as String?,
      descriptions: fields[2] as String?,
      status: fields[3] as String?,
      todoMinutes: fields[4] as int?,
      todoSeconds: fields[5] as int?,
      endMinutes: fields[6] as int?,
      endSeconds: fields[7] as int?,
      isPlaying: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Todos obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.descriptions)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.todoMinutes)
      ..writeByte(5)
      ..write(obj.todoSeconds)
      ..writeByte(6)
      ..write(obj.endMinutes)
      ..writeByte(7)
      ..write(obj.endSeconds)
      ..writeByte(8)
      ..write(obj.isPlaying);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
