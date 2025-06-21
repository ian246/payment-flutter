import 'package:flutter/material.dart';
import '../models/model.dart';

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
    // Configurações de cor baseadas no tipo de pacote
    late Gradient gradient;
    late Color borderColor;
    late List<Color> shadowColors;

    switch (package.size) {
      case PackageSize.small:
        gradient = const LinearGradient(
          colors: [Colors.black87, Colors.grey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
        borderColor = Colors.black;
        shadowColors = [Colors.grey.withAlpha(204), Colors.black.withAlpha(77)];
        break;
      case PackageSize.medium:
        gradient = const LinearGradient(
          colors: [Colors.deepPurple, Colors.indigo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
        borderColor = Colors.deepPurple.shade300;
        shadowColors = [
          Colors.deepPurple.withAlpha(128),
          Colors.indigo.withAlpha(77),
        ];
        break;
      case PackageSize.large:
        gradient = const LinearGradient(
          colors: [Colors.deepPurple, Colors.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
        borderColor = Colors.tealAccent.shade400;
        shadowColors = [
          Colors.deepPurple.withAlpha(128),
          Colors.teal.withAlpha(77),
        ];
        break;
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 2),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: gradient,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho com ícone
              Row(
                children: [
                  Icon(
                    _getPackageIcon(package.size),
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    package.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Descrição
              Text(
                package.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),

              // Rodapé com preço e botão
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Preço',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                      Text(
                        'R\$${package.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withAlpha(51),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.white.withAlpha(128)),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Assinar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getPackageIcon(PackageSize size) {
    switch (size) {
      case PackageSize.small:
        return Icons.star_border;
      case PackageSize.medium:
        return Icons.star_half;
      case PackageSize.large:
        return Icons.star;
    }
  }
}
