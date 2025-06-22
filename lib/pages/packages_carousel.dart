import 'package:flutter/material.dart';
import 'package:payment_flutter/components/widget_card.dart';
import 'package:payment_flutter/data/repository.dart';
import 'package:payment_flutter/models/model.dart';

class PackagesCarousel extends StatefulWidget {
  final Function(PaymentPackage) onPackageSelected;

  const PackagesCarousel({super.key, required this.onPackageSelected});

  @override
  State<PackagesCarousel> createState() => _PackagesCarousel();
}

class _PackagesCarousel extends State<PackagesCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  final packages = PackageRepository.getAllPackages();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 320, // Altura ajustável conforme necessidade
          child: PageView.builder(
            controller: _pageController,
            itemCount: packages.length,
            itemBuilder: (context, index) {
              final package = packages[index];
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
                  }
                  return Center(
                    child: Transform.scale(scale: value, child: child),
                  );
                },
                child: GestureDetector(
                  onTap: () => widget.onPackageSelected(package),
                  child: PackageCard(
                    package: package,
                    onPressed: () => widget.onPackageSelected(package),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // Indicadores de página
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            packages.length,
            (index) => Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? Colors.deepPurple
                    : Colors.grey.withAlpha(100),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
