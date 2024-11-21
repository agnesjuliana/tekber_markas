import 'package:flutter/material.dart';

class SkipWidget extends StatelessWidget {
  const SkipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: Add skip functionality
      },
      child: const Text(
        'Lewati',
        style: TextStyle(
          color:  Color(0xFFDA1E3D),
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
