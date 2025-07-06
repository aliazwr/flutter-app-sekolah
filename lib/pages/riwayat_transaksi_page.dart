import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RiwayatTransaksiPage extends StatefulWidget {
  const RiwayatTransaksiPage({super.key});

  @override
  State<RiwayatTransaksiPage> createState() => _RiwayatTransaksiPageState();
}

class _RiwayatTransaksiPageState extends State<RiwayatTransaksiPage> {
  // Data transaksi dari API
  List<Map<String, dynamic>> _transaksiList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransaksi();
  }

  Future<void> _loadTransaksi() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final transaksiData = await ApiService.fetchTransaksi();
      setState(() {
        _transaksiList = List<Map<String, dynamic>>.from(transaksiData);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        backgroundColor: const Color(0xFF5B7FFF),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTransaksi,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Memuat data transaksi...'),
                ],
              ),
            )
          : _transaksiList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum ada transaksi',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadTransaksi,
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _transaksiList.length,
              itemBuilder: (context, index) {
                final transaksi = _transaksiList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5B7FFF).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.receipt,
                        color: Color(0xFF5B7FFF),
                      ),
                    ),
                    title: Text(
                      transaksi['nomor'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          transaksi['nama'],
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          transaksi['jenis'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                transaksi['status'],
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Rp ${transaksi['total'].toString()}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF5B7FFF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      _showDetailTransaksi(transaksi);
                    },
                  ),
                );
              },
            ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Transaksi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Hari Ini'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementasi filter hari ini
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Bulan Ini'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementasi filter bulan ini
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Semua Transaksi'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementasi tampilkan semua
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  void _showDetailTransaksi(Map<String, dynamic> transaksi) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detail Transaksi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow('Nomor', transaksi['nomor']),
            _DetailRow('Nama', transaksi['nama']),
            _DetailRow('Jenis', transaksi['jenis']),
            _DetailRow('Jumlah', transaksi['jumlah'].toString()),
            _DetailRow('Harga Satuan', 'Rp ${transaksi['harga']}'),
            _DetailRow('Total', 'Rp ${transaksi['total']}'),
            _DetailRow('Tanggal', transaksi['tanggal']),
            _DetailRow('Status', transaksi['status']),
            if (transaksi['keterangan'] != null)
              _DetailRow('Keterangan', transaksi['keterangan']),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _printTransaksi(transaksi);
            },
            child: const Text('Cetak'),
          ),
        ],
      ),
    );
  }

  void _printTransaksi(Map<String, dynamic> transaksi) {
    // TODO: Implementasi cetak transaksi
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur cetak akan segera tersedia')),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
