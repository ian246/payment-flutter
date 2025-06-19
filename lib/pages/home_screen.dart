import 'package:flutter/material.dart';
import 'package:payment_flutter/components/widget_card.dart';
import 'package:payment_flutter/data/repository.dart';
import 'package:payment_flutter/models/model.dart';
import 'package:payment_flutter/pages/payment_history_screen.dart';
import 'package:payment_flutter/services/payment_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PaymentService _paymentService = PaymentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escolha seu Pacote"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Selecione o pacote ideal para você',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...PackageRepository.packages.map(
              (package) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PackageCard(
                  package: package,
                  onPressed: () => _handlePackageSelection(package, context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Pacotes'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Histórico de Pagamentos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentHistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handlePackageSelection(
    PaymentPackage package,
    BuildContext context,
  ) async {
    await _paymentService.handlePackageSelection(package, context);
  }
}
