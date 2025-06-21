class PaymentStore {
  static List<Map<String, dynamic>> payments = [];

  static void addPayment(Map<String, dynamic> payment) {
    payments.add(payment);
  }

  static List<Map<String, dynamic>> getAllPayments() {
    return List.from(
      payments.reversed,
    ); 
  }
}
