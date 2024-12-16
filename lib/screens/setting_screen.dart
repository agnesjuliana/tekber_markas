import 'package:flutter/material.dart';
import 'package:tekber_markas/screens/profile_edit_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Pengaturan',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // Pengaturan Akun
          _settingsTile(
            icon: Icons.person_outline,
            title: 'Pengaturan akun',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileEditScreen(),
                ),
              );
            },
          ),
          _settingsTile(
            icon: Icons.settings_outlined,
            title: 'Pengaturan aplikasi',
            onTap: () {},
          ),
          _settingsTile(
            icon: Icons.help_outline,
            title: 'Pusat bantuan',
            onTap: () {},
          ),
          _settingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Kebijakan privasi',
            onTap: () {},
          ),
          _settingsTile(
            icon: Icons.feedback_outlined,
            title: 'Umpan balik',
            onTap: () {},
          ),
          // Undang Teman
          ListTile(
            leading: Icon(Icons.group_add_outlined, color: Colors.grey[400]),
            title: Text(
              'Undang teman',
              style: TextStyle(color: Colors.grey[400], fontSize: 16),
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'akan datang',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            onTap: () {},
          ),
          SizedBox(height: 30),
          // Tombol Keluar
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDA1E3D), // Custom red color
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                // Logika untuk Keluar
              },
              child: Text(
                'KELUAR',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk ListTile Setting
  Widget _settingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
      onTap: onTap,
    );
  }
}
