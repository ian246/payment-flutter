import 'package:flutter/material.dart';
import 'package:payment_flutter/models/model.dart';
import 'package:payment_flutter/models/payment_handler.dart';
import 'package:payment_flutter/services/add_payment_handler.dart';
// import 'package:payment_flutter/payment_store.dart';

class PaymentService {
   final Map<String, PaymentHandler> _paymentHandlers = {
    'card': CardPaymentHandler(),
    'pix': PixPaymentHandler(),
    'boleto': BoletoPaymentHandler(),
  };
      Future<void> handlePackageSelection(
    PaymentPackage package,
    BuildContext context, {required Null Function() onPaymentConfirmed}
  ) async {
    final paymentMethod = await _showPaymentMethodDialog(context);
    if (paymentMethod == null) return;
    await _paymentHandlers[paymentMethod]?.makePayment(
      package,
      context,
      onPaymentConfirmed: () {
        // Callback adicional se necessário
      },
    );
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
