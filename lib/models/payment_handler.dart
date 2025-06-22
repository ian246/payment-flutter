import 'package:flutter/material.dart';
import 'package:payment_flutter/data/repository.dart';
import 'package:payment_flutter/models/model.dart';
import 'package:intl/intl.dart';

abstract class PaymentHandler {
  Future<void> makePayment(
    PaymentPackage package,
    BuildContext context, {
    VoidCallback? onPaymentConfirmed,
  });

  Future<void> recordPayment({
    required String paymentMethod,
    required double amount,
    required PaymentPackage package,
    required VoidCallback onPaymentConfirmed,
  }) async {
    final now = DateTime.now();
    final hora = DateFormat('HH:mm:ss').format(now);
    final data = DateFormat('dd/MM/yyyy').format(now);

    final paymentRecord = PaymentRecord(
      id: now.millisecondsSinceEpoch.toString(),
      title: 'Pagamento $paymentMethod',
      description: 'Pagamento realizado em $data às $hora',
      amount: amount,
      date: now,
      paymentMethod: paymentMethod,
    );

       await PackageRepository.addPaymentRecord(paymentRecord);
    onPaymentConfirmed();
  }
}