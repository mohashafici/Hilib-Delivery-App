import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/app_theme.dart';
import 'meat_selection_screen.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
  'assets/animations/celebration.json',
  height: 250,
  repeat: false,
  errorBuilder: (context, error, stackTrace) {
    return Column(
      children: [
        Icon(Icons.error, size: 80, color: Colors.red),
        Text(
          'Animation failed to load!',
          style: TextStyle(fontSize: 18, color: Colors.redAccent),
        ),
      ],
    );
  },
),

              const SizedBox(height: 32),
              Text(
                '🎉 Mahadsanid! 🎉',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '✅ Dalabkaaga waa la helay ✅',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Fadlan la soco, dalabkaaga si dhakhso ah ayaa laguugu keenayaa! 🚀🥩',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const MeatSelectionScreen(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home, color: Colors.white),
                label: const Text(
                  'Ku noqo Bogga Hore',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
