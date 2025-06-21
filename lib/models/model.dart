enum PackageSize { small, medium, large }

class PaymentPackage {
  final String id;
  final String title;
  final String description;
  final double price;
  final PackageSize size;

  PaymentPackage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.size,
  });
}

class PaymentRecord {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final String paymentMethod; // 'card' ou 'pix'

  PaymentRecord({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.paymentMethod,
  });
}
