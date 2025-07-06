import 'package:flutter/material.dart';
import '../services/api_service.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomorTransaksiController = TextEditingController();
  final _namaPelangganController = TextEditingController();
  final _jenisTransaksiController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _hargaController = TextEditingController();
  final _keteranganController = TextEditingController();

  bool isLoading = false;

  String _selectedJenisTransaksi = 'Pembayaran SPP';
  final List<String> _jenisTransaksiList = [
    'Pembayaran SPP',
    'Pembayaran Uang Makan',
    'Pembayaran Seragam',
    'Pembayaran Buku',
    'Pembayaran Lainnya',
  ];

  @override
  void initState() {
    super.initState();
    _generateNomorTransaksi();
  }

  void _generateNomorTransaksi() {
    final now = DateTime.now();
    final nomor =
        'TRX${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}';
    _nomorTransaksiController.text = nomor;
  }

  void _hitungTotal() {
    if (_jumlahController.text.isNotEmpty && _hargaController.text.isNotEmpty) {
      // Trigger rebuild untuk update total
      setState(() {
        // Total akan dihitung di _hitungTotalDisplay()
      });
    }
  }

  void _simpanTransaksi() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final data = {
          'nomor_transaksi': _nomorTransaksiController.text,
          'nama_pelanggan': _namaPelangganController.text,
          'jenis_transaksi': _selectedJenisTransaksi,
          'jumlah': _jumlahController.text,
          'harga_satuan': _hargaController.text,
          'total': _hitungTotalValue().toString(),
          'keterangan': _keteranganController.text,
          'status': 'Lunas',
        };

        final success = await ApiService.tambahTransaksi(data);

        setState(() {
          isLoading = false;
        });

        if (success) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Sukses'),
              content: const Text('Transaksi berhasil disimpan!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text(
                'Gagal menyimpan transaksi!\n\nPeriksa:\n1. Koneksi internet\n2. Server API aktif\n3. Database tersedia',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Terjadi kesalahan: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Transaksi'),
        backgroundColor: const Color(0xFF5B7FFF),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nomor Transaksi
              TextFormField(
                controller: _nomorTransaksiController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Transaksi',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.receipt),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 16),

              // Nama Pelanggan
              TextFormField(
                controller: _namaPelangganController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pelanggan',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama pelanggan harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Jenis Transaksi
              DropdownButtonFormField<String>(
                value: _selectedJenisTransaksi,
                decoration: const InputDecoration(
                  labelText: 'Jenis Transaksi',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _jenisTransaksiList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedJenisTransaksi = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jenis transaksi harus dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Jumlah
              TextFormField(
                controller: _jumlahController,
                decoration: const InputDecoration(
                  labelText: 'Jumlah',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => _hitungTotal(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah harus diisi';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Jumlah harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Harga
              TextFormField(
                controller: _hargaController,
                decoration: const InputDecoration(
                  labelText: 'Harga Satuan',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => _hitungTotal(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga harus diisi';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Harga harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Total (Read Only)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _hitungTotalDisplay(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5B7FFF),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Keterangan
              TextFormField(
                controller: _keteranganController,
                decoration: const InputDecoration(
                  labelText: 'Keterangan (Opsional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _simpanTransaksi,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B7FFF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          'Simpan Transaksi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _hitungTotalDisplay() {
    if (_jumlahController.text.isNotEmpty && _hargaController.text.isNotEmpty) {
      final jumlah = int.tryParse(_jumlahController.text) ?? 0;
      final harga = double.tryParse(_hargaController.text) ?? 0;
      final total = jumlah * harga;
      return 'Rp ${total.toStringAsFixed(0)}';
    }
    return 'Rp 0';
  }

  double _hitungTotalValue() {
    if (_jumlahController.text.isNotEmpty && _hargaController.text.isNotEmpty) {
      final jumlah = int.tryParse(_jumlahController.text) ?? 0;
      final harga = double.tryParse(_hargaController.text) ?? 0;
      return jumlah * harga;
    }
    return 0.0;
  }

  @override
  void dispose() {
    _nomorTransaksiController.dispose();
    _namaPelangganController.dispose();
    _jenisTransaksiController.dispose();
    _jumlahController.dispose();
    _hargaController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }
}
