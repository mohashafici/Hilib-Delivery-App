import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../models/meat_option.dart';
import 'order_confirmation_screen.dart';

class OrderSummaryScreen extends StatelessWidget {
  final MeatOption meatOption;
  final double weight;
  final String deliveryOption;
  final String name;
  final String phone;
  final String? address;
  final String paymentMethod;

  const OrderSummaryScreen({
    super.key,
    required this.meatOption,
    required this.weight,
    required this.deliveryOption,
    required this.name,
    required this.phone,
    required this.paymentMethod,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    final totalPrice = meatOption.pricePerKg * weight;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Xaqiijinta Dalabka'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSection(
                      'Faahfaahinta Hilibka',
                      [
                        _buildRow('Nooca:', meatOption.name),
                        _buildRow('Miisaanka:', '${weight.toStringAsFixed(1)} kg'),
                        _buildRow('Qiimaha:', '\$${totalPrice.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      'Macluumaadka Gaarsiinta',
                      [
                        _buildRow('Qaabka:', deliveryOption),
                        if (address != null) _buildRow('Cinwaanka:', address!),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      'Macluumaadka Macmiilka',
                      [
                        _buildRow('Magaca:', name),
                        _buildRow('Telefoonka:', phone),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      'Qaabka Lacag Bixinta',
                      [_buildRow('Nooca:', paymentMethod)],
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      'Wadarta Guud',
                      [
                        _buildRow('Qiimaha Hilibka:', '\$${totalPrice.toStringAsFixed(2)}'),
                        if (deliveryOption == 'Guriga')
                          _buildRow('Qiimaha Gaarsiinta:', '\$5.00'),
                        const Divider(),
                        _buildRow(
                          'Wadarta:',
                          '\$${(totalPrice + (deliveryOption == 'Guriga' ? 5.0 : 0.0)).toStringAsFixed(2)}',
                          isBold: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderConfirmationScreen(),
                  ),
                );
              },
              child: const Text(
                'Xaqiiji Dalabka',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
} 