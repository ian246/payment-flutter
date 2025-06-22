import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:payment_flutter/data/repository.dart';
import 'package:payment_flutter/models/model.dart';

part 'payment_card.g.dart';

@HiveType(typeId: 1)
class CardPaymentService extends HiveObject {
  @HiveField(0)
  String last4Digits;

  CardPaymentService({required this.last4Digits});
}

class CardPaymentHandlerService {
  Map<String, dynamic>? paymentIntent;

  Future<void> makeCardPayment(
    PaymentPackage package,
    BuildContext context, {
    VoidCallback? onPaymentConfirmed,
  }) async {
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

      await _displayPaymentSheet(package, context, onPaymentConfirmed);
    } catch (err) {
      _showErrorDialog(context, 'Erro no pagamento: $err');
    }
  }

  Future<void> _displayPaymentSheet(
    PaymentPackage package,
    BuildContext context,
    VoidCallback? onPaymentConfirmed,
  ) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      final paymentRecord = PaymentRecord(
        id: paymentIntent!['id'],
        title: package.title,
        description: package.description,
        amount: package.price,
        date: DateTime.now(),
        paymentMethod: 'card',
      );

      await PackageRepository.addPaymentRecord(paymentRecord);

      final cardData = CardPaymentService(last4Digits: '1234');
      final box = await Hive.openBox<CardPaymentService>('card_payments');
      await box.add(cardData);

      if (context.mounted) {
        _showSuccessDialog(context, 'Pagamento realizado com sucesso!');
        onPaymentConfirmed?.call();
      }

      paymentIntent = null;
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

    if (baseurl == null) throw Exception('URL incorreta');

    final body = {
      'amount': (double.parse(amount) * 100).toInt().toString(),
      'currency': currency,
    };

    final response = await http.post(
      Uri.parse(baseurl),
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    return json.decode(response.body);
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
