import 'package:flutter/material.dart';
import 'package:payment_flutter/services/payment_store.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  List<Map<String, dynamic>> payments = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadPayments();
  }

  void _loadPayments() {
    setState(() {
      payments = PaymentStore.getAllPayments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Pagamentos')),
      body: payments.isEmpty
          ? const Center(child: Text('Nenhum pagamento encontrado.'))
          : ListView.builder(
              itemCount: payments.length,
              itemBuilder: (context, index) {
                final payment = payments[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: payment['tipo'] == 'PIX'
                          ? Colors.green[100]
                          : Colors.deepPurple[100],
                      child: Icon(
                        payment['tipo'] == 'PIX'
                            ? Icons.pix
                            : Icons.credit_card,
                        color: payment['tipo'] == 'PIX'
                            ? Colors.green
                            : Colors.deepPurple,
                      ),
                    ),
                    title: Text(
                      'R\$ ${payment['valor'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tipo: ${payment['tipo']}'),
                        Text(
                          'Data: ${payment['data']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing:  Text(
                          'Hora: ${payment['hora']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                  ),
                );
              },
            ),
    );
  }
}