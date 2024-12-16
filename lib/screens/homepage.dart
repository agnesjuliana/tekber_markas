import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tekber_markas/widgets/banner.dart';
import 'package:tekber_markas/widgets/event_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        // Ambil data user dari Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userName = userDoc['name'] ?? 'User'; // Ganti nama jika ditemukan
          });
        }
      }
    } catch (e) {
      print("Error mengambil data pengguna: $e");
    }
  }

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
                backgroundImage: AssetImage(profileImage), // Gambar default
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
          BannerWidget(), // Menggunakan BannerWidget di sini
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 5, backgroundColor: Color(0xFFDA1E3D)),
              SizedBox(width: 8),
              CircleAvatar(radius: 4, backgroundColor: Color(0xFFC1C6CC)),
              SizedBox(width: 8),
              CircleAvatar(radius: 4, backgroundColor: Color(0xFFC1C6CC)),
            ],
          ),
          SizedBox(height: 54),
          Divider(color: Color.fromARGB(255, 255, 255, 255), thickness: 1.0, height: 20.0),
          SizedBox(height: 27),
          Text('Event Lainnya', style: _headerStyle(16, FontWeight.w600)),
          SizedBox(height: 12),
          Container(
            height: 261,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('events').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error memuat data event"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final events = snapshot.data!.docs;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: EventCard(eventData: events[index]),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 50), // Padding tambahan di bagian bawah
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
