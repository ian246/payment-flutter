import 'package:hive/hive.dart';
import 'package:payment_flutter/models/model.dart';

class PackageRepository {
  static Box<PaymentPackage> get packagesBox => Hive.box<PaymentPackage>('packages');
  static Box<PaymentRecord> get paymentsBox => Hive.box<PaymentRecord>('payments');

  static List<PaymentPackage> get packages => packagesBox.values.toList();

  static List<PaymentRecord> get paymentHistory => paymentsBox.values.toList();

  static Future<void> addPaymentRecord(PaymentRecord record) async {
    await paymentsBox.add(record);
  }

  static Future<void> clearAll() async {
    await packagesBox.clear();
    await paymentsBox.clear();
  }
}