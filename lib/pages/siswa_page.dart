import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SiswaPage extends StatefulWidget {
  const SiswaPage({super.key});

  @override
  State<SiswaPage> createState() => _SiswaPageState();
}

class _SiswaPageState extends State<SiswaPage> {
  List<dynamic> siswa = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final data = await ApiService.fetchSiswa();
      setState(() {
        siswa = data;
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
      appBar: AppBar(
        title: const Text('Data Siswa'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: loadData),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? Center(child: Text('Error: $error'))
          : ListView.builder(
              itemCount: siswa.length,
              itemBuilder: (context, index) {
                final item = siswa[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(item['NAMA'] ?? '-'),
                    subtitle: Text(
                      'NIK: ${item['NIK'] ?? '-'} | Kelas: ${item['KELAS'] ?? '-'}',
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<bool>(
            context: context,
            builder: (context) => const _TambahSiswaDialog(),
          );
          if (result == true) {
            await loadData();
          }
        },
        tooltip: 'Tambah Siswa',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TambahSiswaDialog extends StatefulWidget {
  const _TambahSiswaDialog();

  @override
  State<_TambahSiswaDialog> createState() => _TambahSiswaDialogState();
}

class _TambahSiswaDialogState extends State<_TambahSiswaDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nikC = TextEditingController();
  final TextEditingController namaC = TextEditingController();
  final TextEditingController alamatC = TextEditingController();
  final TextEditingController jkC = TextEditingController();
  final TextEditingController ttlC = TextEditingController();
  final TextEditingController kelasC = TextEditingController();
  bool isLoading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah Siswa'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nikC,
                decoration: const InputDecoration(labelText: 'NIK'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'NIK wajib diisi' : null,
              ),
              TextFormField(
                controller: namaC,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: alamatC,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              TextFormField(
                controller: jkC,
                decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
              ),
              TextFormField(
                controller: ttlC,
                decoration: const InputDecoration(labelText: 'TTL'),
              ),
              TextFormField(
                controller: kelasC,
                decoration: const InputDecoration(labelText: 'Kelas'),
              ),
              if (error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.pop(context, false),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () async {
                  if (_formKey.currentState?.validate() != true) return;
                  setState(() {
                    isLoading = true;
                    error = null;
                  });
                  try {
                    print('📝 Form data: NIK=${nikC.text}, NAMA=${namaC.text}');

                    final result = await ApiService.tambahSiswa({
                      'NIK': nikC.text.trim(),
                      'NAMA': namaC.text.trim(),
                      'ALAMAT': alamatC.text.trim(),
                      'JENIS_KELAMIN': jkC.text.trim(),
                      'TTL': ttlC.text.trim(),
                      'KELAS': kelasC.text.trim(),
                    });

                    print('📊 ApiService Result: $result');

                    if (result['success'] == true) {
                      print('✅ Siswa berhasil ditambahkan');
                      Navigator.pop(context, true);
                    } else {
                      print('❌ Gagal menambah siswa');
                      print('📝 Error Message: ${result['message']}');
                      setState(() {
                        error =
                            'Gagal menambah data siswa: ${result['message']}';
                      });
                    }
                  } catch (e) {
                    print('💥 Exception saat tambah siswa: $e');
                    setState(() {
                      error = 'Error: $e';
                    });
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text('Simpan'),
        ),
      ],
    );
  }
}
