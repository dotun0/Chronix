// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskClassAdapter extends TypeAdapter<TaskClass> {
  @override
  final int typeId = 0;

  @override
  TaskClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskClass(
      taskName: fields[0] as String,
      taskState: fields[1] as bool,
      taskCategory: fields[2] as String,
      taskTime: fields[3] as DateTime,
      id: fields[4] as String,
      catColor: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TaskClass obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.taskName)
      ..writeByte(1)
      ..write(obj.taskState)
      ..writeByte(2)
      ..write(obj.taskCategory)
      ..writeByte(3)
      ..write(obj.taskTime)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.catColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
