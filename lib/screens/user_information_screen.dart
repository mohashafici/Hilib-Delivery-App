import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../models/meat_option.dart';
import 'payment_method_screen.dart';

class UserInformationScreen extends StatefulWidget {
  final MeatOption meatOption;
  final double weight;
  final String deliveryOption;

  const UserInformationScreen({
    super.key,
    required this.meatOption,
    required this.weight,
    required this.deliveryOption,
  });

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  bool _showOrderSummary = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Macluumaadka Macmiilka'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Magaca oo Buuxa',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppTheme.primaryColor),
                          ),
                        ),
                        validator: (value) => 
                            value?.isEmpty ?? true ? 'Fadlan geli magacaaga' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Telefoon Lambarka',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppTheme.primaryColor),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) => 
                            value?.isEmpty ?? true ? 'Fadlan geli telefoonkaaga' : null,
                      ),
                      if (widget.deliveryOption == 'Guriga') ...[
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            labelText: 'Cinwaanka',
                            prefixIcon: const Icon(Icons.location_on),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppTheme.primaryColor),
                            ),
                          ),
                          maxLines: 3,
                          validator: (value) => 
                              value?.isEmpty ?? true ? 'Fadlan geli cinwaankaaga' : null,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildOrderSummaryCard(),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentMethodScreen(
                          meatOption: widget.meatOption,
                          weight: widget.weight,
                          deliveryOption: widget.deliveryOption,
                          name: _nameController.text,
                          phone: _phoneController.text,
                          address: widget.deliveryOption == 'Guriga' 
                              ? _addressController.text 
                              : null,
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Sii Wad',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    final totalPrice = widget.meatOption.pricePerKg * widget.weight;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _showOrderSummary = !_showOrderSummary;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Faahfaahin Dalabka',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                  ),
                  const Spacer(),
                  Icon(
                    _showOrderSummary ? Icons.remove : Icons.add,
                    color: AppTheme.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          if (_showOrderSummary)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  const Divider(),
                  _buildSummaryRow('Nooca:', widget.meatOption.name),
                  _buildSummaryRow('Miisaanka:', '${widget.weight.toStringAsFixed(1)} kg'),
                  _buildSummaryRow('Qiimaha:', '\$${totalPrice.toStringAsFixed(2)}'),
                  _buildSummaryRow('Qaabka:', widget.deliveryOption),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 