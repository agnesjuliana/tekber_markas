import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tekber_markas/screens/profile_screen.dart';
import 'package:tekber_markas/screens/favorite_event.dart';
import 'package:tekber_markas/screens/search_screen.dart';
import 'package:tekber_markas/widgets/banner.dart';
import 'package:tekber_markas/widgets/event_card.dart';
import 'package:tekber_markas/widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  String userName = "Nama Pengguna"; // Nama default
  String profileImage = 'lib/assets/images/profil.png'; // Gambar default

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fungsi untuk mengambil data user dari Firestore
  Future<void> fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userName = userDoc['name'] ?? 'User';
          });
        }
      }
    } catch (e) {
      print("Error mengambil data pengguna: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomePageContent(userName: userName), // Halaman utama
      EventScreen(),                      // Halaman pencarian
      FavoriteScreen(),                    // Halaman favorit
      ProfileScreen(),                     // Halaman profil
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// Kelas HomePageContent yang memuat EventCard dan Firebase data
class HomePageContent extends StatelessWidget {
  final String userName;

  const HomePageContent({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('lib/assets/images/profil.png'), // Gambar default
              ),
              SizedBox(width: 17),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Halo,', style: _headerStyle(14, FontWeight.w400)),
                  Text(
                    userName, // Nama user dari Firestore
                    style: _headerStyle(20, FontWeight.w700),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Image.asset('lib/assets/icons/notification.png'),
                onPressed: () {},
                iconSize: 44,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: 36),
          Text('Sorotan Event', style: _headerStyle(25, FontWeight.w700)),
          SizedBox(height: 12),
          BannerWidget(), // Banner
          SizedBox(height: 16),
          Text('Event Lainnya', style: _headerStyle(16, FontWeight.w600)),
          SizedBox(height: 12),
          Container(
            height: 261,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('event').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error memuat data event: ${snapshot.error}"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final events = snapshot.data!.docs;

                if (events.isEmpty) {
                  return Center(child: Text("Tidak ada event tersedia."));
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: EventCard(eventData: event),
                    );
                  },
                );
              },
            ),

          ),
          SizedBox(height: 50), // Jarak tambahan
        ],
      ),
    );
  }

  TextStyle _headerStyle(double fontSize, FontWeight fontWeight) {
    return TextStyle(
      color: Colors.black,
      fontFamily: 'Open Sans',
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: 0.75,
    );
  }
}
