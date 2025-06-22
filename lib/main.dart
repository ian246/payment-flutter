import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:payment_flutter/models/model.dart';
import 'package:payment_flutter/pages/home_screen.dart';

import 'package:payment_flutter/services/payment_card.dart';
import 'package:payment_flutter/services/payment_pix.dart';
import 'package:payment_flutter/services/payment_boleto.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  await Hive.initFlutter();

  Hive.registerAdapter(CardPaymentServiceAdapter());
  Hive.registerAdapter(PixPaymentServiceAdapter());
  Hive.registerAdapter(BoletoPaymentServiceAdapter());

  await Hive.openBox<PaymentPackage>('packages');
  await Hive.openBox<PaymentRecord>('payments');

  await _loadInitialData();
  
  runApp(const MyApp());
}



Future<void> _loadInitialData() async {
  final packagesBox = Hive.box<PaymentPackage>('packages');
  if (packagesBox.isEmpty) {
    await packagesBox.addAll([
      PaymentPackage(
        id: '1',
        title: 'Pacote Básico',
        description: 'Ideal para pequenos negócios\n- Suporte básico\n- Até 10 transações/mês',
        price: 19.99,
        size: PackageSize.small,
      ),
      PaymentPackage(
        id: '2',
        title: 'Pacote Intermediário',
        description: 'Para negócios em crescimento\n- Suporte prioritário\n- Até 50 transações/mês',
        price: 49.99,
        size: PackageSize.medium,
      ),
      PaymentPackage(
        id: '3',
        title: 'Pacote Premium',
        description: 'Solução completa\n- Suporte 24/7\n- Transações ilimitadas\n- Relatórios avançados',
        price: 89.99,
        size: PackageSize.large,
      ),
    ]);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Pagamentos',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple,
          secondary: Colors.tealAccent,
        ),
        scaffoldBackgroundColor: Colors.grey[900],
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
