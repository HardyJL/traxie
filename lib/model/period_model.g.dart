// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeriodModelAdapter extends TypeAdapter<PeriodModel> {
  @override
  final int typeId = 10;

  @override
  PeriodModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PeriodModel(
      cycleLength: fields[12] == null ? 28 : fields[12] as int,
      periodLength: fields[11] == null ? 6 : fields[11] as int,
      periodStartDate: fields[13] as DateTime,
      periodEndDate: fields[14] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PeriodModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(11)
      ..write(obj.periodLength)
      ..writeByte(12)
      ..write(obj.cycleLength)
      ..writeByte(13)
      ..write(obj.periodStartDate)
      ..writeByte(14)
      ..write(obj.periodEndDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeriodModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
