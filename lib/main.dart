import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'halaman_1.dart';
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

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/Animation - 1751533145029.json',
                width: 260,
                repeat: true,
              ),
              const SizedBox(height: 32),
              const Text(
                'Selamat Datang di Aplikasi Sekolah',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Akses informasi dan layanan sekolah dengan mudah',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HalamanSatu(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
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
                  child: const Text('Masuk Menu Siswa'),
                ),
              ),
            ],
          ),
        ),
      ),
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

class ModernHomePage extends StatelessWidget {
  const ModernHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                color: Colors.white,
                shadowColor: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 32,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withValues(alpha: 0.15),
                              blurRadius: 32,
                              spreadRadius: 4,
                              offset: Offset(0, 12),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                            'assets/Animation - 1751470298633.json',
                            repeat: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Selamat Datang Di',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.black87,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'Ali Azwar System!',
                            textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                            colors: [
                              Colors.blueAccent,
                              Colors.black87,
                              Colors.teal,
                              Colors.deepOrange,
                            ],
                          ),
                        ],
                        isRepeatingAnimation: true,
                        repeatForever: true,
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Tidak apa-apa lambat asal tidak diam di tempat',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Poppins',
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HalamanSatu(),
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Mulai'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                  elevation: 6,
                  shadowColor: Colors.blueAccent.withValues(alpha: 0.2),
                ),
              ),
            ],
          ),
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
