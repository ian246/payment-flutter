// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentPackageAdapter extends TypeAdapter<PaymentPackage> {
  @override
  final int typeId = 1;

  @override
  PaymentPackage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentPackage(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as double,
      size: fields[4] as PackageSize,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentPackage obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.size);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentPackageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PaymentRecordAdapter extends TypeAdapter<PaymentRecord> {
  @override
  final int typeId = 2;

  @override
  PaymentRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentRecord(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      amount: fields[3] as double,
      date: fields[4] as DateTime,
      paymentMethod: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentRecord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.paymentMethod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PackageSizeAdapter extends TypeAdapter<PackageSize> {
  @override
  final int typeId = 0;

  @override
  PackageSize read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PackageSize.small;
      case 1:
        return PackageSize.medium;
      case 2:
        return PackageSize.large;
      default:
        return PackageSize.small;
    }
  }

  @override
  void write(BinaryWriter writer, PackageSize obj) {
    switch (obj) {
      case PackageSize.small:
        writer.writeByte(0);
        break;
      case PackageSize.medium:
        writer.writeByte(1);
        break;
      case PackageSize.large:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackageSizeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
