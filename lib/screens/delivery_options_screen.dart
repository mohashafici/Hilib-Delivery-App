import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../models/meat_option.dart';
import 'user_information_screen.dart';

class DeliveryOptionsScreen extends StatefulWidget {
  final MeatOption meatOption;
  final double weight;

  const DeliveryOptionsScreen({
    super.key,
    required this.meatOption,
    required this.weight,
  });

  @override
  State<DeliveryOptionsScreen> createState() => _DeliveryOptionsScreenState();
}

class _DeliveryOptionsScreenState extends State<DeliveryOptionsScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dooro Qaabka Gaarsiinta'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          _buildDeliveryOption(
                            'Guriga',
                            Icons.home,
                            'Gurigaaga ayaa laguugu keenayaa',
                          ),
                          const SizedBox(height: 16),
                          _buildDeliveryOption(
                            'Pickup',
                            Icons.store,
                            'Adiga ayaa naga soo qaadan doona',
                          ),
                        ],
                      ),
                      _buildOrderSummary(),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: selectedOption == null
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserInformationScreen(
                                        meatOption: widget.meatOption,
                                        weight: widget.weight,
                                        deliveryOption: selectedOption!,
                                      ),
                                    ),
                                  );
                                },
                          child: const Text(
                            'Sii Wad',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    final totalPrice = widget.meatOption.pricePerKg * widget.weight;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Faahfaahin Dalabka',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Nooca:', widget.meatOption.name),
            _buildSummaryRow('Miisaanka:', '${widget.weight.toStringAsFixed(1)} kg'),
            _buildSummaryRow('Qiimaha:', '\$${totalPrice.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDeliveryOption(String title, IconData icon, String description) {
    final isSelected = selectedOption == title;
    
    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedOption = title;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: isSelected ? AppTheme.primaryColor : Colors.grey,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? AppTheme.primaryColor : Colors.black,
                      ),
                    ),
                    Text(description),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: AppTheme.primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
