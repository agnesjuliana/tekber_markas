// File: lib/screens/homepage.dart

import 'package:flutter/material.dart';
import 'package:tekber_markas/widgets/banner.dart';  // Import BannerWidget
import 'package:tekber_markas/widgets/event_card.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Homepage')),
      body: Column(
        children: [
          BannerWidget(),  // Memanggil BannerWidget yang sudah terpisah
          const SizedBox(height: 16),  
          Expanded(
            child: ListView(
              children: const [
                EventCard(),  // Memanggil EventCard
                EventCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
