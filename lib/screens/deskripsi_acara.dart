import 'package:flutter/material.dart';
import 'package:tekber_markas/screens/form_pendaftaran.dart'; 

class DeskripsiAcaraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MARKAS'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('lib/assets/images/event_image.png'), 
            SizedBox(height: 20),
            Text(
              'Kelas Intensif Hustler',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'by 1000 Startup Markas Surabaya',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.grey),
                SizedBox(width: 8),
                Text('Senin, 1 November 2023'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey),
                SizedBox(width: 8),
                Text('18:00 - 21:00 WIB'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '1000 Start Up Digital, program by Kominfo\n\n'
                  'Mempersembahkan "Sekolah Beta Intensif - Hustler" Workshop & Coaching Class: '
                  '1 November - 30 November 2023 (Setiap Senin & Kamis)\n\n'
                  'Lokasi: MARKAS Surabaya - Jl. Sidosermo II KAV F-106 Sidosermo - Wonocolo\n\n'
                  'Bersama Majukan Negeri Melalui Teknologi, Karena Indonesia Maju!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FormPendaftaranPage()),
                  );
                },
                child: Text('Daftar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
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
