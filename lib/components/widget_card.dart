import 'package:flutter/material.dart';
import 'package:payment_flutter/models/model.dart';

class PackageCard extends StatelessWidget {
  final PaymentPackage package;
  final VoidCallback onPressed;

  const PackageCard({
    super.key,
    required this.package,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color backgroundColor;

    switch (package.size) {
      case PackageSize.small:
        borderColor = Colors.blue;
        backgroundColor = Colors.blue.shade50;
        break;
      case PackageSize.medium:
        borderColor = Colors.green;
        backgroundColor = Colors.green.shade50;
        break;
      case PackageSize.large:
        borderColor = Colors.purple;
        backgroundColor = Colors.purple.shade50;
        break;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor, width: 2),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              package.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: borderColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(package.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${package.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: borderColor,
                  ),
                ),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: borderColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Assinar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
