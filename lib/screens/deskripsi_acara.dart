import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeskripsiAcaraPage extends StatelessWidget {
  final String eventId;

  const DeskripsiAcaraPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MARKAS'),
        backgroundColor: const Color(0xFFDA1E3D),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('event').doc(eventId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("Event tidak ditemukan"));
          }

          final eventData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(eventData['bannerUrl'] ?? ''),
                const SizedBox(height: 20),
                Text(
                  eventData['title'] ?? '',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  eventData['organizer'] ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(eventData['date']?.toDate().toString() ?? ''),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  eventData['description'] ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Tambahkan navigasi ke form_pendaftaran jika diperlukan
                    },
                    child: const Text('Daftar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDA1E3D),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
