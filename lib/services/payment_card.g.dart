// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardPaymentServiceAdapter extends TypeAdapter<CardPaymentService> {
  @override
  final int typeId = 1;

  @override
  CardPaymentService read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardPaymentService(
      last4Digits: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CardPaymentService obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.last4Digits);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardPaymentServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
