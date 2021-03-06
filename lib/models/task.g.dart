// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task()
      ..scheduleId = fields[0] as int
      ..task = fields[1] as String
      ..icon = fields[2] as String
      ..isDone = fields[3] as bool
      ..isAllDay = fields[4] as bool
      ..remind = fields[5] as bool
      ..remindOn = fields[6] as DateTime
      ..from = fields[7] as DateTime
      ..to = fields[8] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.scheduleId)
      ..writeByte(1)
      ..write(obj.task)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.isDone)
      ..writeByte(4)
      ..write(obj.isAllDay)
      ..writeByte(5)
      ..write(obj.remind)
      ..writeByte(6)
      ..write(obj.remindOn)
      ..writeByte(7)
      ..write(obj.from)
      ..writeByte(8)
      ..write(obj.to);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
