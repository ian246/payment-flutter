import 'package:flutter/material.dart';
import 'package:payment_flutter/data/repository.dart';
import 'package:payment_flutter/models/model.dart';
import 'package:payment_flutter/services/payment_store.dart'; // <-- Adicionado

class PaymentPix {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePixPayment(
    PaymentPackage package,
    BuildContext context, {
    VoidCallback? onPaymentConfirmed,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pagamento via PIX'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Use o QR Code abaixo para pagar:'),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
              ),
              child: const Icon(Icons.qr_code, size: 100, color: Colors.green),
            ),
            const SizedBox(height: 20),
            const Text('Ou copie o código:'),
            const SizedBox(height: 10),
            const SelectableText(
              '00020126360014BR.GOV.BCB.PIX0114+556799999999952040000530398654045.005802BR5925MERCADO PAGO SERVICOS6009SAO PAULO61080540900062250521abc123def456ghi789jkl6304A56A',
              style: TextStyle(fontFamily: 'monospace'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _simulatePixConfirmation(
                package,
                context,
                onPaymentConfirmed: onPaymentConfirmed,
              );
            },
            child: const Text('Já paguei'),
          ),
        ],
      ),
    );
  }

  Future<void> _simulatePixConfirmation(
    PaymentPackage package,
    BuildContext context, {
    VoidCallback? onPaymentConfirmed,
  }) async {
    await Future.delayed(const Duration(seconds: 3));

    final paymentRecord = PaymentRecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: package.title,
      description: package.description,
      amount: package.price,
      date: DateTime.now(),
      paymentMethod: 'pix',
    );

    PackageRepository.paymentHistory.add(paymentRecord);

    // ✅ Adiciona também ao estado global temporário
    PaymentStore.addPayment({
      'tipo': 'PIX',
      'valor': package.price,
      'data': DateTime.now().toString(),
    });

    if (context.mounted) {
      _showSuccessDialog(context, 'Pagamento PIX confirmado!');
      onPaymentConfirmed?.call(); // atualiza histórico se necessário
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 100),
            const SizedBox(height: 10),
            Text(message),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 10),
            Text(message),
          ],
        ),
      ),
    );
  }
}
