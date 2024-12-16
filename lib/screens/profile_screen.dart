import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tekber_markas/widgets/event_card.dart';
import 'package:tekber_markas/screens/setting_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'Username';
  String email = 'Email';
  String about = 'Tentang Saya belum diisi.';

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
            username = userDoc['name'] ?? 'User';
            email = user.email ?? 'No Email';
            about = userDoc['about'] ?? 'Tentang Saya belum diisi.'; // Ambil field "about"
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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () async {
              // Tunggu navigasi selesai, lalu panggil fetchUserData
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
              // Refresh data setelah kembali dari SettingsScreen
              fetchUserData();
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
                    backgroundImage: AssetImage('lib/assets/images/profile_photo.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                about,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const Text(
                'Event yang Diikuti',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildRegisteredEventsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisteredEventsList() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return Center(child: Text("User tidak ditemukan"));

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('registrations')
          .where('userId', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final registrations = snapshot.data!.docs;

        if (registrations.isEmpty) {
          return Center(child: Text("Belum ada event yang diikuti"));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: registrations.length,
          itemBuilder: (context, index) {
            final registration = registrations[index].data() as Map<String, dynamic>;
            final eventId = registration['eventId'];

            // Ambil data event dari koleksi "event" berdasarkan eventId
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('event').doc(eventId).get(),
              builder: (context, eventSnapshot) {
                if (eventSnapshot.hasError) {
                  return Center(child: Text("Error memuat data event"));
                }

                if (eventSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!eventSnapshot.hasData || !eventSnapshot.data!.exists) {
                  return Center(child: Text("Event tidak ditemukan"));
                }

                final eventData = eventSnapshot.data!.data() as Map<String, dynamic>;

                // Tampilkan EventCard dengan data yang sesuai
                return EventCard(
                  eventData: eventSnapshot.data!,
                );
              },
            );
          },
        );
      },
    );
  }
}
