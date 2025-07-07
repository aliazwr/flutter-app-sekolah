import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/project_detail_page.dart';
import 'pages/siswa_page.dart';
import 'pages/guru_page.dart';
import 'pages/kelas_page.dart';
import 'pages/presensi_page.dart';
import 'pages/transaksi_page.dart';
import 'pages/riwayat_transaksi_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Sekolah',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/siswa': (context) => const SiswaPage(),
        '/guru': (context) => const GuruPage(),
        '/kelas': (context) => const KelasPage(),
        '/presensi': (context) => const PresensiPage(),
        '/detail': (context) => const ProjectDetailPage(),
        '/transaksi': (context) => const TransaksiPage(),
        '/riwayat-transaksi': (context) => const RiwayatTransaksiPage(),
      },
    );
  }
}

class HalamanBaru extends StatelessWidget {
  const HalamanBaru({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Baru'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Ini adalah halaman baru!',
          style: TextStyle(fontSize: 24, fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}
