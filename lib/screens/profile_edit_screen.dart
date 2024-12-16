import 'package:flutter/material.dart';

class ProfileEditScreen extends StatelessWidget {
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
                    backgroundImage: AssetImage('assets/profile_pic.png'), // Ganti sesuai gambar profil
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

          // Form Input
          _inputField(
            title: 'Nama Depan *',
            hintText: 'Adhitya',
          ),
          _inputField(
            title: 'Nama Belakang *',
            hintText: 'Pratama',
          ),
          _inputField(
            title: 'Alamat Email *',
            hintText: 'adhityapmp@gmail.com',
          ),
          _inputField(
            title: 'Nomor Handphone *',
            hintText: '+62 821 1234 5678',
          ),
          _inputField(
            title: 'Tanggal Lahir *',
            hintText: '16/02/2003',
          ),

          SizedBox(height: 30),

          // Tombol Simpan Perubahan
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDA1E3D), // Warna merah sesuai desain
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                // Logika untuk menyimpan perubahan
              },
              child: Text(
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
