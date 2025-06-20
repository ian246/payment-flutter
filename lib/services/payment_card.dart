import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:payment_flutter/data/repository.dart';
import 'package:payment_flutter/models/model.dart';

class PaymentCard {
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
      await makeCardPayment(package, context);
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

  Future<void> makeCardPayment(
    PaymentPackage package,
    BuildContext context,
  ) async {
    try {
      paymentIntent = await _createPaymentIntent(
        package.price.toString(),
        'BRL',
      );
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: package.title,
          style: Theme.of(context).brightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Colors.deepPurple,
              componentBorder: Colors.deepPurple,
            ),
          ),
        ),
      );

      await _displayPaymentSheet(package, context);
    } catch (err) {
      _showErrorDialog(context, 'Erro no pagamento: $err');
    }
  }
   Future<void> _displayPaymentSheet(
    PaymentPackage package,
    BuildContext context,
  ) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        final paymentRecord = PaymentRecord(
          id: paymentIntent!['id'],
          title: package.title,
          description: package.description,
          amount: package.price,
          date: DateTime.now(),
          paymentMethod: 'card',
        );

        PackageRepository.paymentHistory.add(paymentRecord);

        if (context.mounted) {
          _showSuccessDialog(context, 'Pagamento realizado com sucesso!');
        }
        paymentIntent = null;
      });
    } on StripeException catch (err) {
      if (context.mounted) {
        _showErrorDialog(
          context,
          'Erro no pagamento: ${err.error.localizedMessage}',
        );
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(context, 'Erro: $e');
      }
    }
  }
  Future<Map<String, dynamic>> _createPaymentIntent(
    String amount,
    String currency,
  ) async {
    final secretKey = dotenv.env['STRIPE_SECRET_KEY'];
    final baseurl = dotenv.env['DATABASE_URL'];

    if (baseurl == null) {
      throw Exception('URL incorreta');
    }

    String calculateAmount(String amount) {
      final calculatedAmount = (double.parse(amount)) * 100;
      return calculatedAmount.toStringAsFixed(0);
    }

    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
    };

    try {
      var response = await http.post(
        Uri.parse(baseurl),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
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
