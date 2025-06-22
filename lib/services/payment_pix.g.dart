// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_pix.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PixPaymentServiceAdapter extends TypeAdapter<PixPaymentService> {
  @override
  final int typeId = 4;

  @override
  PixPaymentService read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PixPaymentService(
      chavePix: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PixPaymentService obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.chavePix);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PixPaymentServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
