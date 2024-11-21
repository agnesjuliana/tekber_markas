import 'package:flutter/material.dart';
import 'package:tekber_markas/widgets/start_button_widget.dart';
import 'package:tekber_markas/widgets/logo_text_widget.dart';
import 'package:tekber_markas/widgets/skip_widget.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              // Logo Section
              LogoWidget(),
              SizedBox(height: 20),
              // Title
              Text(
                'MARKAS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:  Color(0xFFDA1E3D),
                ),
              ),
              SizedBox(height: 40),
              // Buttons
              ButtonWidget(),
              SizedBox(height: 20),
              // Skip Section
              SkipWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
