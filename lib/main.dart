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

class CoffeeMenuPage extends StatelessWidget {
  const CoffeeMenuPage({super.key});

  final List<Map<String, dynamic>> coffeeMenu = const [
    {
      'name': 'Espresso',
      'desc': 'Kopi hitam pekat, tanpa gula.',
      'price': 18000,
      'image': null,
    },
    {
      'name': 'Cappuccino',
      'desc': 'Espresso, susu, dan foam lembut.',
      'price': 22000,
      'image': null,
    },
    {
      'name': 'Latte',
      'desc': 'Espresso dan susu creamy.',
      'price': 23000,
      'image': null,
    },
    {
      'name': 'Americano',
      'desc': 'Espresso dengan air panas.',
      'price': 19000,
      'image': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Kopi'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.brown,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: coffeeMenu.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final coffee = coffeeMenu[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.local_cafe,
                  size: 32,
                  color: Colors.brown,
                ),
              ),
              title: Text(
                coffee['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(coffee['desc']),
              trailing: Text(
                'Rp${coffee['price']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoffeeDetailPage(coffee: coffee),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CoffeeDetailPage extends StatelessWidget {
  final Map<String, dynamic> coffee;
  const CoffeeDetailPage({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coffee['name']),
        backgroundColor: Colors.white,
        foregroundColor: Colors.brown,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.local_cafe,
                size: 64,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              coffee['name'],
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              coffee['desc'],
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              'Rp${coffee['price']}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Pesanan Berhasil'),
                      content: Text('Kamu memesan ${coffee['name']}.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Pesan'),
              ),
            ),
          ],
        ),
      ),
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
