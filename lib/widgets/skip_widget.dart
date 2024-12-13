import 'package:flutter/material.dart';
import 'package:tekber_markas/screens/homepage.dart';

class SkipWidget extends StatelessWidget {
  const SkipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Mengarahkan ke HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
      child: const Text(
        'Lewati',
        style: TextStyle(
          color: Color(0xFFDA1E3D),
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
