import 'package:payment_flutter/models/model.dart';

class PackageRepository {
  static final List<PaymentPackage> packages = [
    PaymentPackage(
      id: '1',
      title: 'Pacote Básico',
      description:
          'Ideal para pequenos negócios\n- Suporte básico\n- Até 10 transações/mês',
      price: 9.99,
      size: PackageSize.small,
    ),
    PaymentPackage(
      id: '2',
      title: 'Pacote Intermediário',
      description:
          'Para negócios em crescimento\n- Suporte prioritário\n- Até 50 transações/mês',
      price: 29.99,
      size: PackageSize.medium,
    ),
    PaymentPackage(
      id: '3',
      title: 'Pacote Premium',
      description:
          'Solução completa\n- Suporte 24/7\n- Transações ilimitadas\n- Relatórios avançados',
      price: 99.99,
      size: PackageSize.large,
    ),
  ];

  static List<PaymentRecord> paymentHistory = [];
}
