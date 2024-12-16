import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tekber_markas/screens/profile_edit_screen.dart';
import 'package:tekber_markas/screens/login_account.dart';  // Pastikan Anda mengimport halaman login

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
          // Tombol Log Out
          _settingsTile(
            icon: Icons.exit_to_app,
            title: 'Log Out',
            onTap: () async {
              await _logOut(context);
            },
          ),
          // Tombol Hapus Akun
          _settingsTile(
            icon: Icons.delete_forever,
            title: 'Hapus Akun',
            onTap: () async {
              await _deleteAccount(context);
            },
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
        ],
      ),
    );
  }

  // Fungsi untuk melakukan log out
  Future<void> _logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Log out dari Firebase
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginAccountScreen()), // Ganti ke halaman login
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Anda berhasil keluar")));
    } catch (e) {
      print("Error during log out: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal keluar: $e")));
    }
  }

  // Fungsi untuk menghapus akun
  Future<void> _deleteAccount(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Hapus data user dari Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

        // Hapus akun dari Firebase Authentication
        await user.delete();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginAccountScreen()), // Ganti ke halaman login setelah penghapusan
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Akun berhasil dihapus")));
      }
    } catch (e) {
      print("Error deleting account: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal menghapus akun: $e")));
    }
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
