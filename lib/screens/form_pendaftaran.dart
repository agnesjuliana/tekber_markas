import 'package:flutter/material.dart';

class FormPendaftaranPage extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Pendaftaran'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('lib/assets/images/markas_logo.png'), // Ganti dengan logo acara Anda
                SizedBox(height: 20),
                Text(
                  'Kelas Intensif Hustler',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'by 1000 Startup Markas Surabaya',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                // Nama
                Text('Nama', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama Anda',
                    filled: true,
                    fillColor: Colors.grey[200],
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
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Nomor WhatsApp wajib diisi' : null,
                ),
                SizedBox(height: 16),

                // Domisili
                Text('Domisili', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan domisili Anda',
                    filled: true,
                    fillColor: Colors.grey[200],
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
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Instansi wajib diisi' : null,
                ),
                SizedBox(height: 16),

                // Posisi
                Text('Posisi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _positionController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan posisi Anda',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (value) => value!.isEmpty ? 'Posisi wajib diisi' : null,
                ),
                SizedBox(height: 20),

                // Tombol Submit
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Tampilkan dialog konfirmasi
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Icon(Icons.check_circle,
                                color: Colors.green, size: 50),
                            content: Text(
                              'Kamu telah terdaftar dalam kegiatan ini!',
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
