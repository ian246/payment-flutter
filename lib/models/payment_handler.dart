
import 'package:flutter/material.dart';
import 'package:payment_flutter/data/repository.dart';
import 'package:payment_flutter/models/model.dart';
import 'package:payment_flutter/services/payment_store.dart';

abstract class PaymentHandler {
  Future<void> makePayment(
    PaymentPackage package,
    BuildContext context, {
    VoidCallback? onPaymentConfirmed,
  });

  void recordPayment({
    required String paymentMethod,
    required double amount,
    required VoidCallback onPaymentConfirmed,
  }) {
    final now = DateTime.now();
    final hora = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    final data = "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";

    final paymentRecord = PaymentRecord(
      id: now.toString(),
      title: '',
      description: '',
      amount: amount,
      date: now,
      paymentMethod: paymentMethod,
    );

    PackageRepository.paymentHistory.add(paymentRecord);
    PaymentStore.addPayment({
      'tipo': paymentMethod,
      'valor': amount,
      'data': data,
      'hora': hora,
    });

    onPaymentConfirmed.call();
  }
}