import 'package:flutter/material.dart';
import 'package:payment_flutter/models/payment_handler.dart';
import 'package:payment_flutter/services/payment_boleto.dart';
import 'package:payment_flutter/services/payment_card.dart';
import 'package:payment_flutter/services/payment_pix.dart';
import 'package:payment_flutter/models/model.dart';

class CardPaymentHandler extends PaymentHandler {
  final CardPaymentHandlerService _handler = CardPaymentHandlerService();

  @override
  Future<void> makePayment(
    PaymentPackage package,
    BuildContext context, {
    VoidCallback? onPaymentConfirmed,
  }) async {
    await _handler.makeCardPayment(
      package,
      context,
      onPaymentConfirmed: () => recordPayment(
        paymentMethod: 'card',
        package: package,
        amount: package.price,
        onPaymentConfirmed: onPaymentConfirmed ?? () {},
      ),
    );
  }
}

class PixPaymentHandler extends PaymentHandler {
  final PixPaymentHandlerService _handler = PixPaymentHandlerService();

  @override
  Future<void> makePayment(
    PaymentPackage package,
    BuildContext context, {
    VoidCallback? onPaymentConfirmed,
  }) async {
    await _handler.makePixPayment(
      package,
      context,
      onPaymentConfirmed: () => recordPayment(
        paymentMethod: 'pix',
        package: package,
        amount: package.price,
        onPaymentConfirmed: onPaymentConfirmed ?? () {},
      ),
    );
  }
}

class BoletoPaymentHandler extends PaymentHandler {
  final BoletoPaymentHandlerService _handler = BoletoPaymentHandlerService();

  @override
  Future<void> makePayment(
    PaymentPackage package,
    BuildContext context, {
    VoidCallback? onPaymentConfirmed,
  }) async {
    await _handler.makeBoletoPayment(
      package,
      context,
      onPaymentConfirmed: () => recordPayment(
        paymentMethod: 'boleto',
        package: package,
        amount: package.price,
        onPaymentConfirmed: onPaymentConfirmed ?? () {},
      ),
    );
  }
}
