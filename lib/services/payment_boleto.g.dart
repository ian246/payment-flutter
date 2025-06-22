// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_boleto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BoletoPaymentServiceAdapter extends TypeAdapter<BoletoPaymentService> {
  @override
  final int typeId = 2;

  @override
  BoletoPaymentService read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BoletoPaymentService(
      codigoDeBarras: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BoletoPaymentService obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.codigoDeBarras);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoletoPaymentServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
