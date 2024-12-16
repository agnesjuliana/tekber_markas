import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'form_pendaftaran.dart';

class DeskripsiAcaraPage extends StatefulWidget {
  final String eventId;

  const DeskripsiAcaraPage({super.key, required this.eventId});

  @override
  _DeskripsiAcaraPageState createState() => _DeskripsiAcaraPageState();
}

class _DeskripsiAcaraPageState extends State<DeskripsiAcaraPage> {
  DocumentSnapshot? eventData;

  @override
  void initState() {
    super.initState();
    fetchEventData();
  }

  // Fungsi untuk mengambil data event berdasarkan eventId
  Future<void> fetchEventData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('event')
          .doc(widget.eventId)
          .get();

      setState(() {
        eventData = doc;
      });
    } catch (e) {
      print("Error fetching event data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (eventData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('MARKAS'),
          backgroundColor: Color(0xFFDA1E3D),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Ambil data dari Firestore
    String title = eventData!['title'] ?? 'Judul Tidak Tersedia';
    String bannerUrl = eventData!['bannerUrl'] ?? '';
    String description = eventData!['description'] ?? '';
    String date = eventData!['date'] != null
        ? eventData!['date'].toDate().toString()
        : 'Tanggal Tidak Tersedia';
    String location = eventData!['location'] ?? '';
    String organizer = eventData!['organizer'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Acara'),
        backgroundColor: Color(0xFFDA1E3D),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(bannerUrl, height: 200, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Penyelenggara: $organizer'),
            SizedBox(height: 10),
            Text('Lokasi: $location'),
            SizedBox(height: 10),
            Text('Tanggal: $date'),
            SizedBox(height: 20),
            Text(description),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print("Registrasi Event: ${widget.eventId}");
                  // Navigasi ke FormPendaftaranPage dan bawa eventId
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormPendaftaranPage(eventId: widget.eventId),
                    ),
                  );
                },
                child: Text('Daftar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDA1E3D),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
