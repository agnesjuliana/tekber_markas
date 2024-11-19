import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  // Hapus const di sini
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // Aksi ketika tombol settings ditekan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Gambar Profil
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('lib/assets/images/profile_photo.jpg'), // Ganti dengan URL gambar profil Anda
                  ),
                  const SizedBox(width: 16),
                  // Nama dan Username
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Adhitya Pratama',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('@yaelaadhit'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildStatCard('45 event', Colors.red),
                          const SizedBox(width: 8),
                          _buildStatCard('30 sertifikat', Colors.red),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              // Tentang Saya
              const Text(
                'Tentang saya',
                style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Hola 👋 Saya seorang Junior UI/UX Designer yang sedang mencari peluang baru untuk terlibat dalam proyek-proyek menarik. Saya sangat terbuka untuk berkolaborasi dan bekerja sama dengan Anda dalam proyek-proyek mendatang 🤝",
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              // Tab Event dan Sertifikat
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: Colors.red,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: 'Event'),
                        Tab(text: 'Sertifikat'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3, // Tinggi konten tab
                      child: TabBarView(
                        children: [
                          // Konten Event
                          _buildEventList(), // Fungsi untuk membangun daftar event
                          // Konten Sertifikat
                          _buildCertificateList(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          _buildBottomNavigationBar(), // Bottom navigation bar
    );
  }

Widget _buildEventList() {
  return ListView(
    children: [
      _buildEventCard(
        title: 'Kelas Intensif Hacker Episode 1',
        date: 'Selasa, 14 November 2023',
        location: 'Jemursari, Surabaya',
        imagePath: 'lib/assets/images/event_image.png',
      ),
      _buildEventCard(
        title: 'Sekolah Beta Intensif: Hustler',
        date: 'Rabu, 15 November 2023',
        location: 'Jemursari, Surabaya',
        imagePath: 'lib/assets/images/event_image_1.png',
      ),
    ],
  );
}

Widget _buildEventCard({
  required String title,
  required String date,
  required String location,
  required String imagePath,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8), // Margin antar card event
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Membuat sudut card melengkung
    ),
    elevation: 2, // Memberikan bayangan lembut pada card
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Gambar Event di bagian atas
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Image.asset(
            imagePath, // Gambar event dari parameter
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        const Divider(
          color: Colors.red, // Garis merah sebagai pembatas
          thickness: 2,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul Event
              Text(
                title, // Judul event dari parameter
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // Ukuran font lebih besar untuk judul
                ),
              ),
              const SizedBox(height: 8),
              // Tanggal Event dengan ikon kalender berwarna merah
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.red), // Ikon kalender merah
                  const SizedBox(width: 4),
                  Text(date, style: const TextStyle(color: Colors.grey)), // Tanggal dari parameter
                ],
              ),
              const SizedBox(height: 4),
              // Lokasi Event dengan ikon lokasi berwarna merah
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.red), // Ikon lokasi merah
                  const SizedBox(width: 4),
                  Text(location, style:
                   const TextStyle(color:
                   Colors.grey)), // Lokasi dari parameter
                ],
              ),
              const SizedBox(height:
               16),
              Align(alignment:
               Alignment.centerRight, child:
               TextButton(onPressed:
               () {}, child:
               const Text('Detail acara', style:
               TextStyle(color:
               Colors.red, decoration:
               TextDecoration.underline))), 
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildStatCard(String text, Color color) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Padding dalam card statistik
      decoration:
          BoxDecoration(color: color.withOpacity(0.1), borderRadius:
           BorderRadius.circular(8)),
      child:
       Text(text, style:
       TextStyle(color:
       color)),
    );
  }

  

Widget _buildCertificateList() {
  return ListView.builder(
    itemCount: 4, // Jumlah sertifikat (sesuaikan)
    itemBuilder: (context, index) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8), // Margin antar card sertifikat
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Membuat sudut card melengkung
        ),
        elevation: 2, // Memberikan bayangan lembut pada card
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Gambar Sertifikat
                  Image.asset(
                    'lib/assets/images/certificate_icon.png', // Gambar sertifikat (sesuaikan)
                    width: 40,
                  ),
                  const SizedBox(width: 16),
                  // Nama Sertifikasi dan Detail
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sertifikasi Hipster Pemula Episode 1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.school, size: 16, color: Colors.grey), // Ikon sekolah
                            SizedBox(width: 4),
                            Text('Sekolah Beta', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: Colors.grey), // Ikon kalender
                            SizedBox(width: 4),
                            Text('Diterbitkan Oktober 2023', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(), // Garis pemisah antara informasi sertifikat dan tombol
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Warna tombol merah
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Membuat sudut tombol melengkung
                      ),
                    ),
                    child:
                        const Text('Download sertifikat', style: TextStyle(color: Colors.white)),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side:
                          const BorderSide(color: Colors.red), // Warna garis luar merah
                      shape:
                          RoundedRectangleBorder(borderRadius:
                           BorderRadius.circular(8)), // Sudut melengkung untuk tombol outline
                    ),
                    child:
                        const Text('Cantumkan ke LinkedIn', style:
                         TextStyle(color:
                         Colors.red)), // Teks berwarna merah
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
// Membuat bottom navigation bar.

}

_buildBottomNavigationBar() {
}