import 'package:flutter/material.dart';
import 'package:payment_flutter/services/payment_store.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

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
      payments = PaymentStore.payments;
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
                return ListTile(
                  title: Text('Tipo: ${payment['tipo']}'),
                  subtitle: Text(
                    'Valor: R\$ ${payment['valor']} - ${payment['data']}',
                  ),
                );
              },
            ),
    );
  }
}
