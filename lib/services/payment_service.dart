import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_flutter/models/model.dart';
import 'package:payment_flutter/services/payment_card.dart';
import 'package:payment_flutter/services/payment_pix.dart';

class PaymentService {
  final PaymentCard _paymentCard = PaymentCard();
  final PaymentPix _paymentPix = PaymentPix();
  Map<String, dynamic>? paymentIntent;

  Future<void> preloadStripe() async {
    await Stripe.instance.applySettings();
  }

  Future<void> handlePackageSelection(
    PaymentPackage package,
    BuildContext context,
  ) async {
    final paymentMethod = await _showPaymentMethodDialog(context);
    if (paymentMethod == null) return;

    if (paymentMethod == 'card') {
      await _paymentCard.makeCardPayment(package, context);
    } else {
      await _paymentPix.makePixPayment(package, context);
    }
  }

  Future<String?> _showPaymentMethodDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escolha o método de pagamento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.credit_card, color: Colors.blue),
              title: const Text('Cartão de Crédito'),
              onTap: () => Navigator.pop(context, 'card'),
            ),
            ListTile(
              leading: const Icon(Icons.qr_code, color: Colors.green),
              title: const Text('PIX'),
              onTap: () => Navigator.pop(context, 'pix'),
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long, color: Colors.orange),
              title: const Text('Boleto Bancário'),
              onTap: () => Navigator.pop(context, 'boleto'),
            ),
          ],
        ),
      ),
    );
  }
}
