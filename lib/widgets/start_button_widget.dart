import 'package:flutter/material.dart';
import 'package:tekber_markas/screens/create_account.dart';
import 'package:tekber_markas/screens/login_account.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Login Button
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginAccountScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFDA1E3D),
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: const Text(
            'Masuk',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Register Button
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateAccountScreen(),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(color: Color(0xFFDA1E3D)),
          ),
          child: const Text(
            'Belum punya akun? Daftar',
            style: TextStyle(
              color: Color(0xFFDA1E3D),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
