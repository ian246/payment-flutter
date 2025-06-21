import 'package:flutter/material.dart';
import 'package:payment_flutter/models/model.dart';
import 'package:payment_flutter/data/repository.dart';

class PaymentBoleto {
  Future<void> makeBoletoPayment(
    PaymentPackage package,
    BuildContext context, {
    VoidCallback? onPaymentConfirmed,
  }) async {
    bool paymentWasConfirmed = false;

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pagamento via Boleto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Código de barras:'),
            const SizedBox(height: 12),
            const SelectableText(
              '00190.00009 01234.567890 12345.678901 2 12340000010000',
              style: TextStyle(fontFamily: 'monospace'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                paymentWasConfirmed = true;
                Navigator.pop(context);
                _simulateBoletoConfirmation(
                  package,
                  context,
                  onPaymentConfirmed,
                );
              },
              child: const Text('Simular Pagamento'),
            ),
          ],
        ),
      ),
    ).then((_) {
      if (!paymentWasConfirmed && context.mounted) {
        _showErrorDialog(context, 'Pagamento em Boleto não foi efetuado!');
      }
    });
  }

  void _simulateBoletoConfirmation(
    PaymentPackage package,
    BuildContext context,
    VoidCallback? onPaymentConfirmed,
  ) {
    final paymentRecord = PaymentRecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: package.title,
      description: package.description,
      amount: package.price,
      date: DateTime.now(),
      paymentMethod: 'boleto',
    );

    PackageRepository.paymentHistory.add(paymentRecord);

    if (context.mounted) {
      _showSuccessDialog(context, 'Pagamento via Boleto confirmado!');
      onPaymentConfirmed?.call();
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
