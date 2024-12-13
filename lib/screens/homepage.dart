import 'package:flutter/material.dart';
import 'package:tekber_markas/screens/profile_screen.dart';
import 'package:tekber_markas/screens/favorite_event.dart';
import 'package:tekber_markas/screens/search_screen.dart';
import 'package:tekber_markas/widgets/bottom_navbar.dart';
import 'package:tekber_markas/widgets/banner.dart';
import 'package:tekber_markas/widgets/event_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Daftar halaman yang akan ditampilkan sesuai dengan tab yang dipilih
  final List<Widget> _screens = [
    HomePageContent(),    // Halaman utama HomePage tetap ada
    EventScreen(),        // Halaman Event
    FavoriteScreen(),     // Calendar Screen
    ProfileScreen(),      // Profile Screen
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index; // Memperbarui index tab yang aktif
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex, // Menampilkan halaman sesuai dengan tab yang aktif
        children: _screens,   // Daftar halaman yang akan ditampilkan
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,  // Memanggil fungsi saat tab ditekan
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
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
                backgroundImage: AssetImage('lib/assets/images/profil.png'),
              ),
              SizedBox(width: 17),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Halo,', style: _headerStyle(14, FontWeight.w400)),
                  Text('Adhitya Pratama', style: _headerStyle(20, FontWeight.w700)),
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: EventCard(), // Menggunakan EventCard di sini
                );
              },
            ),
          ),
          SizedBox(height: 50),  // Padding tambahan di bagian bawah untuk memberi jarak dengan BottomNavBar
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
