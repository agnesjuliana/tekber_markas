import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Favorite'),
        backgroundColor: const Color(0xFFDA1E3D), // Red color like bottom navbar
      ),
      body: const Center(
        child: Text('This is the Event Favorite Screen!'),
      ),
    );
  }
}
