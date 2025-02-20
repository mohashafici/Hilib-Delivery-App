import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../models/meat_option.dart';
import 'order_summary_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  final MeatOption meatOption;
  final double weight;
  final String deliveryOption;
  final String name;
  final String phone;
  final String? address;

  const PaymentMethodScreen({
    super.key,
    required this.meatOption,
    required this.weight,
    required this.deliveryOption,
    required this.name,
    required this.phone,
    this.address,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? selectedPayment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dooro Qaabka Lacag Bixinta'),
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
                          _buildPaymentOption(
                            'EVC Plus',
                            Icons.phone_android,
                            'Ku bixi EVC Plus',
                            'assets/images/evc.png',
                          ),
                          const SizedBox(height: 16),
                          _buildPaymentOption(
                            'eDahab',
                            Icons.account_balance_wallet,
                            'Ku bixi eDahab',
                            'assets/images/edahab.png',
                          ),
                          const SizedBox(height: 16),
                          _buildPaymentOption(
                            'Cash',
                            Icons.money,
                            'Lacag caddaan ah',
                            null,
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
                          onPressed: selectedPayment == null
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderSummaryScreen(
                                        meatOption: widget.meatOption,
                                        weight: widget.weight,
                                        deliveryOption: widget.deliveryOption,
                                        name: widget.name,
                                        phone: widget.phone,
                                        address: widget.address,
                                        paymentMethod: selectedPayment!,
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
            _buildSummaryRow('Qaabka:', widget.deliveryOption),
            _buildSummaryRow('Magaca:', widget.name),
            _buildSummaryRow('Telefoonka:', widget.phone),
            if (widget.address != null)
              _buildSummaryRow('Cinwaanka:', widget.address!),
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
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon, String description, String? logoPath) {
    final isSelected = selectedPayment == title;
    
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
            selectedPayment = title;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (logoPath != null)
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 16),
                  child: Image.asset(logoPath),
                )
              else
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryColor : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 24,
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
                ),
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
