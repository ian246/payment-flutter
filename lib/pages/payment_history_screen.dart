import 'package:flutter/material.dart';
import 'package:payment_flutter/components/widget_history_card.dart';
import 'package:payment_flutter/data/repository.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Pagamentos'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: PackageRepository.paymentHistory.isEmpty
          ? const Center(child: Text('Nenhum pagamento realizado ainda'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Seus pagamentos:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...PackageRepository.paymentHistory.map(
                  (payment) => PaymentHistoryCard(payment: payment),
                ),
              ],
            ),
    );
  }
}
