import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:payment_flutter/data/repository.dart';
import 'package:payment_flutter/models/model.dart';
import 'package:intl/intl.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Pagamentos')),
      body: ValueListenableBuilder<Box<PaymentRecord>>(
        valueListenable: PackageRepository.paymentsBox.listenable(),
        builder: (context, box, _) {
          final payments = box.values.toList();
          
          if (payments.isEmpty) {
            return const Center(child: Text('Nenhum pagamento encontrado.'));
          }
          
          return ListView.builder(
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments.reversed.toList()[index];
              final date = DateFormat('dd/MM/yyyy').format(payment.date);
              final time = DateFormat('HH:mm:ss').format(payment.date);
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: payment.paymentMethod == 'pix'
                        ? Colors.green[100]
                        : payment.paymentMethod == 'card'
                            ? Colors.deepPurple[100]
                            : Colors.orange[100],
                    child: Icon(
                      payment.paymentMethod == 'pix'
                          ? Icons.qr_code
                          : payment.paymentMethod == 'card'
                              ? Icons.credit_card
                              : Icons.receipt_long,
                      color: payment.paymentMethod == 'pix'
                          ? Colors.green
                          : payment.paymentMethod == 'card'
                              ? Colors.deepPurple
                              : Colors.orange,
                    ),
                  ),
                  title: Text(
                    'R\$ ${payment.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Método: ${payment.paymentMethod.toUpperCase()}'),
                      Text(
                        'Data: $date',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    'Hora: $time',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}