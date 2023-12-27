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
      title: fields[1] as String?,
      descriptions: fields[2] as String?,
    )
      ..status = fields[3] as String?
      ..minutes = fields[4] as int?
      ..seconds = fields[5] as int?
      ..endMinutes = fields[6] as int?
      ..endSeconds = fields[7] as int?;
  }

  @override
  void write(BinaryWriter writer, Todos obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.descriptions)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.minutes)
      ..writeByte(5)
      ..write(obj.seconds)
      ..writeByte(6)
      ..write(obj.endMinutes)
      ..writeByte(7)
      ..write(obj.endSeconds);
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
