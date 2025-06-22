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

  // Carrega as variáveis de ambiente
  await dotenv.load();

  final publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'];
  if (publishableKey == null) {
    throw Exception('STRIPE_PUBLISHABLE_KEY não encontrado no .env');
  }

  // Configuração do Stripe
  Stripe.publishableKey = publishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  // Inicialização do Hive
  await Hive.initFlutter();

  // Registro dos adapters
  Hive.registerAdapter(PackageSizeAdapter());            // typeId = 0
  Hive.registerAdapter(PaymentPackageAdapter());         // typeId = 1
  Hive.registerAdapter(PaymentRecordAdapter());          // typeId = 2
  Hive.registerAdapter(CardPaymentServiceAdapter());     // typeId = 3
  Hive.registerAdapter(PixPaymentServiceAdapter());      // typeId = 4
  Hive.registerAdapter(BoletoPaymentServiceAdapter());   // typeId = 5


  // Abertura dos boxes
  await Hive.openBox<PaymentPackage>('packages');
  await Hive.openBox<PaymentRecord>('payments');

  // Carrega dados iniciais se necessário
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
        description:
            'Ideal para pequenos negócios\n- Suporte básico\n- Até 10 transações/mês',
        price: 19.99,
        size: PackageSize.small,
      ),
      PaymentPackage(
        id: '2',
        title: 'Pacote Intermediário',
        description:
            'Para negócios em crescimento\n- Suporte prioritário\n- Até 50 transações/mês',
        price: 49.99,
        size: PackageSize.medium,
      ),
      PaymentPackage(
        id: '3',
        title: 'Pacote Premium',
        description:
            'Solução completa\n- Suporte 24/7\n- Transações ilimitadas\n- Relatórios avançados',
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
        colorScheme: const ColorScheme.dark(
          primary: Colors.deepPurple,
          secondary: Colors.tealAccent,
        ),
        scaffoldBackgroundColor: Colors.black,
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
