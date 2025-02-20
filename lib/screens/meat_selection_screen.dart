import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../models/meat_option.dart';
import 'weight_selection_screen.dart';

class MeatSelectionScreen extends StatelessWidget {

  const MeatSelectionScreen({super.key});

  final List<MeatOption> meatOptions = const [
    MeatOption(
      name: 'Hilib Ari',
      description: 'Hilib ari tayo sare leh',
      imageUrl: 'assets/images/goat.png',
      pricePerKg: 12.0,
    ),
    MeatOption(
      name: 'Hilib Geel',
      description: 'Hilib geel caafimaad leh',
      imageUrl: 'assets/images/camel.png',
      pricePerKg: 15.0,
    ),
    MeatOption(
      name: 'Digaag',
      description: 'Digaag fresh ah',
      imageUrl: 'assets/images/chicken.png',
      pricePerKg: 8.0,
    ),
    MeatOption(
      name: 'Maalaay',
      description: 'Maalaay fresh ah',
      imageUrl: 'assets/images/fish.png',
      pricePerKg: 10.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dooro Nooca Hilibka'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: meatOptions.length,
        itemBuilder: (context, index) => _buildMeatCard(context, meatOptions[index]),
      ),
    );
  }

  Widget _buildMeatCard(BuildContext context, MeatOption meat) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WeightSelectionScreen(meatOption: meat),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(child: Image.asset(meat.imageUrl)),
              Text(meat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(meat.description),
              Text('\$${meat.pricePerKg}/kg'),
            ],
          ),
        ),
      ),
    );
  }
}
