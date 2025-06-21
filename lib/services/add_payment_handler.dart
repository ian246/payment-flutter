import 'package:flutter/material.dart';
import 'package:payment_flutter/models/payment_handler.dart';
import 'package:payment_flutter/services/payment_boleto.dart';
import 'package:payment_flutter/services/payment_card.dart';
import 'package:payment_flutter/services/payment_pix.dart';

import '../models/model.dart';

class CardPaymentHandler extends PaymentHandler {
  final PaymentCard _paymentCard = PaymentCard();

  @override
  Future<void> makePayment(PaymentPackage package, BuildContext context, {VoidCallback? onPaymentConfirmed}) async {
    await _paymentCard.makeCardPayment(
      package,
      context,
      onPaymentConfirmed: () => recordPayment(
        paymentMethod: 'Cartão',
        amount: package.price,
        onPaymentConfirmed: onPaymentConfirmed?? (){},
      ),
    );
  }
}

class PixPaymentHandler extends PaymentHandler {
  final PaymentPix _paymentPix = PaymentPix();

  @override
  Future<void> makePayment(PaymentPackage package, BuildContext context, {VoidCallback? onPaymentConfirmed}) async {
    await _paymentPix.makePixPayment(
      package,
      context,
      onPaymentConfirmed: () => recordPayment(
        paymentMethod: 'PIX',
        amount: package.price,
        onPaymentConfirmed: onPaymentConfirmed?? (){},
      ),
    );
  }
}

class BoletoPaymentHandler extends PaymentHandler {
  final PaymentBoleto _paymentBoleto = PaymentBoleto();

  @override
  Future<void> makePayment(PaymentPackage package, BuildContext context, {VoidCallback? onPaymentConfirmed}) async {
    await _paymentBoleto.makeBoletoPayment(
      package,
      context,
      onPaymentConfirmed: () => recordPayment(
        paymentMethod: 'Boleto',
        amount: package.price,
        onPaymentConfirmed: onPaymentConfirmed?? (){},
      ),
    );
  }
}