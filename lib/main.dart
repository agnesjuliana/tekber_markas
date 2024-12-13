import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase Core untuk inisialisasi
import 'firebase_options.dart'; // Konfigurasi Firebase yang dihasilkan
import 'screens/homepage.dart'; // HomePage
import 'screens/start_screen.dart'; // StartScreen (jika diperlukan)

void main() async {
  // Inisialisasi Firebase sebelum menjalankan aplikasi
  WidgetsFlutterBinding.ensureInitialized(); // Wajib jika ada kode async di `main`
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Menggunakan konfigurasi Firebase
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tekber Markas', // Judul aplikasi
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red), // Warna dasar tema
        useMaterial3: true, // Material Design 3
      ),
      debugShowCheckedModeBanner: false, // Menghapus banner debug
      home: StartScreen(), // Halaman awal
    );
  }
}
