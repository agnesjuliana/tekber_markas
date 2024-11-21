import 'package:flutter/material.dart';
import 'package:tekber_markas/screens/login_account.dart';
import 'package:tekber_markas/widgets/input_field_widget.dart';
import 'package:tekber_markas/widgets/logo_widget.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Added for scrollable behavior
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const LogoWidget(),
                const SizedBox(height: 16),
                const Text(
                  'Buat Akun',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                const InputFieldWidget(
                  label: 'Email',
                  hint: 'example@email.com',
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                const InputFieldWidget(
                  label: 'Kata Sandi',
                  hint: 'masukkan kata sandi',
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                const InputFieldWidget(
                  label: 'Nomor Telepon',
                  hint: '081234567890',
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                const InputFieldWidget(
                  label: 'Nama Lengkap',
                  hint: 'Masukkan Nama Anda',
                  obscureText: false,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginAccountScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFDA1E3D), // Custom red color
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
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
                    const Text(
                      'Sudah punya akun?',
                      style: TextStyle(fontSize: 14),
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
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFDA1E3D), // Custom red color
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