import 'package:flutter/material.dart';
import 'package:tekber_markas/screens/login_account.dart';
import 'package:tekber_markas/widgets/input_field_widget.dart';
import 'package:tekber_markas/widgets/logo_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Tambahkan Firestore

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool isLoading = false; // Untuk loading indicator

  // Fungsi untuk membuat akun baru
  Future<void> createAccount() async {
    setState(() {
      isLoading = true; // Menampilkan loading indicator
    });

    try {
      print("Membuat akun...");

      // Buat akun menggunakan Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Simpan data tambahan pengguna ke Firestore
      await FirebaseFirestore.instance
          .collection('users') // Nama koleksi di Firestore
          .doc(userCredential.user!.uid) // Gunakan UID pengguna sebagai ID dokumen
          .set({
        'email': emailController.text.trim(),
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(), // Timestamp saat akun dibuat
      });

      print("Akun berhasil dibuat dan data disimpan di Firestore!");

      // Navigasi ke halaman login
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginAccountScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.message ?? 'Terjadi kesalahan'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Sembunyikan loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const LogoWidget(),
                const SizedBox(height: 16),
                Text(
                  'Buat Akun',
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                InputFieldWidget(
                  controller: emailController,
                  label: 'Email',
                  hint: 'example@email.com',
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                InputFieldWidget(
                  controller: passwordController,
                  label: 'Kata Sandi',
                  hint: 'Masukkan kata sandi',
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                InputFieldWidget(
                  controller: phoneController,
                  label: 'Nomor Telepon',
                  hint: '081234567890',
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                InputFieldWidget(
                  controller: nameController,
                  label: 'Nama Lengkap',
                  hint: 'Masukkan nama Anda',
                  obscureText: false,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: isLoading ? null : createAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDA1E3D),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text(
                    'Daftar',
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun?',
                      style: GoogleFonts.openSans(fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginAccountScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Masuk',
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: const Color(0xFFDA1E3D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
