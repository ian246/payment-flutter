import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:payment_flutter/data/repository.dart';
import 'package:payment_flutter/models/model.dart';

part 'payment_pix.g.dart';

@HiveType(typeId: 0)
class PixPaymentService extends HiveObject {
  @HiveField(0)
  String chavePix;

  PixPaymentService({required this.chavePix});
}

class PixPaymentHandlerService {
  Future<void> makePixPayment(
    PaymentPackage package,
    BuildContext context, {
    VoidCallback? onPaymentConfirmed,
  }) async {
    bool paymentWasConfirmed = false;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pagamento via PIX'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Escaneie o QR Code ou copie o código PIX."),
            const SizedBox(height: 16),
            const SelectableText(
              '00020126360014BR.GOV.BCB.PIX0111+5599999999995204000053039865802BR5913Fulano de Tal6009Sao Paulo62070503***6304ABCD',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              paymentWasConfirmed = true;
              Navigator.pop(context);
              _simulatePixConfirmation(package, context, onPaymentConfirmed);
            },
            child: const Text('Já paguei'),
          ),
        ],
      ),
    ).then((_) {
      if (!paymentWasConfirmed && context.mounted) {
        _showErrorDialog(context, 'Pagamento PIX não foi efetuado!');
      }
    });
  }

  Future<void> _simulatePixConfirmation(
    PaymentPackage package,
    BuildContext context, VoidCallback? onPaymentConfirmed) async {
    final paymentRecord = PaymentRecord(
      id: DateTime.now().toString(),
      title: package.title,
      description: package.description,
      amount: package.price,
      date: DateTime.now(),
      paymentMethod: 'pix',
    );

    await PackageRepository.addPaymentRecord(paymentRecord);

    if (context.mounted) {
      _showSuccessDialog(context, 'Pagamento PIX confirmado!');
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