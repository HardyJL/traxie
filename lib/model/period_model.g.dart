// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeriodModelAdapter extends TypeAdapter<PeriodModel> {
  @override
  final int typeId = 1;

  @override
  PeriodModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PeriodModel(
      cycleLength: fields[1] as int,
      periodLength: fields[0] as int,
      periodStartDate: fields[2] as DateTime,
      periodEndDate: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PeriodModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.periodLength)
      ..writeByte(1)
      ..write(obj.cycleLength)
      ..writeByte(2)
      ..write(obj.periodStartDate)
      ..writeByte(3)
      ..write(obj.periodEndDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeriodModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
