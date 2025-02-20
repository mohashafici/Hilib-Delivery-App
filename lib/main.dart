import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'constants/app_theme.dart';
import 'screens/meat_selection_screen.dart';

void main() {
  runApp(HilibDeliveryApp());
}

class HilibDeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF932F2F),
        scaffoldBackgroundColor: Color(0xFFFFF8F3),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FadeTransition(
                  opacity: _controller,
                  child: Lottie.asset(
                    'assets/animations/meat_delivery_lottie.json',
                    height: 150,
                    repeat: false,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Ku soo dhowow Hilib Delivery',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hilib Tayaysan!',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    _buildFeatureItem('🎯 Hilib Fresh & Nadiif ah'),
                    _buildFeatureItem('🚀 Gaarsiin Degdeg ah'),
                    _buildFeatureItem('💯 Tayo & Aaminimo'),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MeatSelectionScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text(
                      'Dalbo Hadda',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FadeTransition(
        opacity: _controller,
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
