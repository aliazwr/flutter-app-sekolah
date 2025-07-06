import 'package:flutter/material.dart';
import '../services/api_service.dart';

class GuruPage extends StatefulWidget {
  const GuruPage({super.key});

  @override
  State<GuruPage> createState() => _GuruPageState();
}

class _GuruPageState extends State<GuruPage> {
  List<dynamic> guru = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final data = await ApiService.fetchGuru();
      setState(() {
        guru = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Guru')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? Center(child: Text('Error: $error'))
          : ListView.builder(
              itemCount: guru.length,
              itemBuilder: (context, index) {
                final item = guru[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(item['NAMA'] ?? '-'),
                    subtitle: Text(
                      'NIP: ${item['NIP'] ?? '-'} | No HP: ${item['NO_HP'] ?? '-'}',
                    ),
                    trailing: Text(item['JENIS_KELAMIN'] ?? '-'),
                    onTap: () {},
                  ),
                );
              },
            ),
    );
  }
}
