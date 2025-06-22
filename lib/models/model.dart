import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
enum PackageSize {
  @HiveField(0)
  small,
  @HiveField(1)
  medium,
  @HiveField(2)
  large,
}

@HiveType(typeId: 1)
class PaymentPackage {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final PackageSize size;

  PaymentPackage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.size,
  });
}

@HiveType(typeId: 2)
class PaymentRecord {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double amount;
  @HiveField(4)
  final DateTime date;
  @HiveField(5)
  final String paymentMethod;

  PaymentRecord({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.paymentMethod,
  });
}