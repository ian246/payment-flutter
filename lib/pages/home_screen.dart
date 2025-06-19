import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? paymentIntent;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter - Payment Aplication")),
      body: Center(
        child: TextButton(
          onPressed: () async {
            await makePayment();
          },
          child: const Text("MakePayment"),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('100', 'EUR');
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              merchantDisplayName: 'Ikay',
            ),
          )
          .then((value) {});

      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((value) {
            showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 100),
                    SizedBox(height: 10),
                    Text('Payment Successful!'),
                  ],
                ),
              ),
            );
            paymentIntent = null;
          })
          .onError((error, stackTrace) {
            throw Exception(error);
          });
    } on StripeException catch (err) {
      print("error is ---> $err");
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.cancel, color: Colors.red),
                Text('Payment Failed  '),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }
}

createPaymentIntent(String amount, String currency) async {
    final secretKey = dotenv.env['STRIPE_SECRET_KEY'];
  final baseurl = dotenv.env['DATABASE_URL'];
  if(baseurl == null) {
    throw Exception('Url incorrect');
  }

  calculetAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  Map<String, dynamic> body = {
    'amount': calculetAmount(amount),
    'currency': currency, // Corrigido aqui
  };

  try {
    var response = await http.post(
      Uri.parse(baseurl),
    

      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );
    return json.decode(response.body);
  } catch (err) {
    throw Exception(err.toString());
  }
}
