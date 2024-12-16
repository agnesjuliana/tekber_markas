import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'homepage.dart';

class FormPendaftaranPage extends StatefulWidget {
  final String eventId; // Terima eventId dari DeskripsiAcaraPage

  const FormPendaftaranPage({super.key, required this.eventId});

  @override
  _FormPendaftaranPageState createState() => _FormPendaftaranPageState();
}

class _FormPendaftaranPageState extends State<FormPendaftaranPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  // Data pengguna yang sedang login
  String currentUserId = '';
  String currentUserEmail = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Ambil data pengguna yang sedang login
  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserId = user.uid;
        currentUserEmail = user.email ?? '';
        _nameController.text = ''; // Opsional: Jika nama user ada di Firestore, bisa diisi otomatis
      });
    }
  }

  // Fungsi untuk menyimpan data pendaftaran ke Firestore
  Future<void> _submitToFirestore() async {
    final data = {
      'userId': currentUserId,
      'email': currentUserEmail,
      'eventId': widget.eventId, // Simpan ID event yang didaftarkan
      'name': _nameController.text,
      'phone': _phoneController.text,
      'city': _cityController.text,
      'organization': _organizationController.text,
      'position': _positionController.text,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      // Simpan data ke koleksi "registrations"
      await FirebaseFirestore.instance.collection('registrations').add(data);
      _showSuccessDialog();
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Icon(Icons.check_circle, color: Colors.green, size: 50),
        content: Text(
          'Kamu telah terdaftar dalam kegiatan ini!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false, // Hapus semua rute sebelumnya
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }


  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Icon(Icons.error, color: Colors.red, size: 50),
        content: Text(
          'Terjadi kesalahan: $error',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Pendaftaran'),
        backgroundColor: Color(0xFFDA1E3D),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama
                Text('Nama', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama Anda',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (value) => value!.isEmpty ? 'Nama wajib diisi' : null,
                ),
                SizedBox(height: 16),

                // Nomor WhatsApp
                Text('No. WhatsApp', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nomor WhatsApp',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (value) => value!.isEmpty ? 'Nomor WhatsApp wajib diisi' : null,
                ),
                SizedBox(height: 16),

                // Domisili
                Text('Domisili', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan domisili Anda',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (value) => value!.isEmpty ? 'Domisili wajib diisi' : null,
                ),
                SizedBox(height: 16),

                // Instansi
                Text('Instansi/Lembaga/Organisasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _organizationController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan instansi Anda',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                SizedBox(height: 16),

                // Posisi
                Text('Posisi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _positionController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan posisi Anda',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                SizedBox(height: 20),

                // Tombol Submit
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitToFirestore();
                      }
                    },
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
