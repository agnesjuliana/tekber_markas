import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  // Fungsi untuk memuat data user dari Firestore
  Future<void> loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            fullNameController.text = userDoc['name'] ?? '';
            phoneController.text = userDoc['number'] ?? '';
          });
        }
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  // Fungsi untuk menyimpan perubahan ke Firestore
  Future<void> saveChanges() async {
    try {
      setState(() {
        isLoading = true;
      });
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Update data di Firestore tanpa mengubah email
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'name': fullNameController.text.trim(),
          'number': phoneController.text.trim(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profil berhasil diperbarui!")),
        );
        Navigator.of(context).pop(); // Kembali ke halaman profil
      }
    } catch (e) {
      print("Error updating user data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memperbarui profil: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          // Foto Profil
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Logika untuk mengganti foto profil
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_pic.png'),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Sentuh untuk mengganti foto profil',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          // Input Fields
          _inputField(
            title: 'Nama Lengkap *',
            controller: fullNameController,
            hintText: 'Nama Lengkap Anda',
          ),
          _inputField(
            title: 'Nomor Handphone *',
            controller: phoneController,
            hintText: '081234567890',
          ),
          SizedBox(height: 30),
          // Tombol Simpan Perubahan
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDA1E3D),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: isLoading ? null : saveChanges,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'SIMPAN PERUBAHAN',
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

  // Fungsi untuk membuat Input Field
  Widget _inputField({
    required String title,
    required TextEditingController controller,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
