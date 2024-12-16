import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tekber_markas/screens/setting_screen.dart';
import 'deskripsi_acara.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'Username';
  String email = 'Email';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Ambil data user dari Firestore
  Future<void> fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            username = userDoc['name'] ?? 'User'; // Ambil field 'name'
            email = user.email ?? 'No Email'; // Ambil email dari FirebaseAuth
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
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
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'lib/assets/images/profile_photo.jpg'), // Gambar default
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama user dari Firestore
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Email user dari FirebaseAuth
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
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
              const Text(
                'Tentang saya',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Hola 👋 Saya seorang Junior UI/UX Designer yang sedang mencari peluang baru untuk terlibat dalam proyek-proyek menarik. Saya sangat terbuka untuk berkolaborasi dan bekerja sama dengan Anda dalam proyek-proyek mendatang 🤝",
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
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
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: TabBarView(
                        children: [
                          _buildEventList(context),
                          _buildCertificateList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(color: color)),
    );
  }

  Widget _buildEventList(BuildContext context) {
    return ListView(
      children: [
        _buildEventCard(
          context: context,
          title: 'Kelas Intensif Hacker Episode 1',
          date: 'Selasa, 14 November 2023',
          location: 'Jemursari, Surabaya',
          imagePath: 'lib/assets/images/event_image.png',
        ),
      ],
    );
  }

  Widget _buildEventCard({
    required BuildContext context,
    required String title,
    required String date,
    required String location,
    required String imagePath,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateList() {
    return Center(
      child: Text("Daftar Sertifikat Kosong"),
    );
  }
}
