import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Map<String, dynamic>? user;
  const HomePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final userData = (args is Map<String, dynamic>) ? args : user;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFF5B7FFF),
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text(
              userData != null && userData['nama_lengkap'] != null
                  ? userData['nama_lengkap']
                  : 'User',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.black54),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(24),
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        children: [
          _DashboardMenu(
            icon: Icons.people,
            label: 'Data Siswa',
            onTap: () => Navigator.pushNamed(context, '/siswa'),
          ),
          _DashboardMenu(
            icon: Icons.person,
            label: 'Data Guru',
            onTap: () => Navigator.pushNamed(context, '/guru'),
          ),
          _DashboardMenu(
            icon: Icons.class_,
            label: 'Data Kelas',
            onTap: () => Navigator.pushNamed(context, '/kelas'),
          ),
          _DashboardMenu(
            icon: Icons.check_circle,
            label: 'Presensi',
            onTap: () => Navigator.pushNamed(context, '/presensi'),
          ),
          _DashboardMenu(
            icon: Icons.payment,
            label: 'Transaksi',
            onTap: () => Navigator.pushNamed(context, '/transaksi'),
          ),
          _DashboardMenu(
            icon: Icons.receipt_long,
            label: 'Riwayat Transaksi',
            onTap: () => Navigator.pushNamed(context, '/riwayat-transaksi'),
          ),
        ],
      ),
    );
  }
}

class _DashboardMenu extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _DashboardMenu({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF5B7FFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 48),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
