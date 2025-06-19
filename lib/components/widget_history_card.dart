import 'package:flutter/material.dart';
import 'package:payment_flutter/models/model.dart';

class PaymentHistoryCard extends StatelessWidget {
  final PaymentRecord payment;

  const PaymentHistoryCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    Color borderColor = payment.paymentMethod == 'card'
        ? Colors.blue
        : Colors.green;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  payment.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text(
                    payment.paymentMethod.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: borderColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(payment.description),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Valor: \$${payment.amount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Data: ${payment.date.day}/${payment.date.month}/${payment.date.year}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
