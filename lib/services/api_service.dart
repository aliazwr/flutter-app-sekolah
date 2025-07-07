import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // Ganti baseUrl sesuai alamat API PHP kamu di XAMPP
  // Untuk Android Emulator: http://10.0.2.2/api.php
  // Untuk iOS Simulator: http://localhost/api.php
  // Untuk device fisik: http://IP_ADDRESS_KOMPUTER/api.php
  static const String baseUrl = 'http://10.0.2.2/api.php';

  // Login (POST)
  static Future<Map<String, dynamic>?> login(
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: {'action': 'login', 'username': username, 'password': password},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        return data['user'];
      }
    }
    return null;
  }

  // Get all data (default GET)
  static Future<Map<String, dynamic>> fetchAll() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        try {
          return json.decode(response.body);
        } catch (parseError) {
          print('Error parsing JSON: $parseError');
          print('Response body: ${response.body}');
          throw Exception('Response tidak valid dari server');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Server mengembalikan response yang tidak valid');
      }
      throw Exception('Gagal mengambil data dari server: $e');
    }
  }

  // Get Siswa
  static Future<List<dynamic>> fetchSiswa() async {
    final data = await fetchAll();
    return data['Siswa'] ?? [];
  }

  // Get Guru
  static Future<List<dynamic>> fetchGuru() async {
    final data = await fetchAll();
    return data['DataGuru'] ?? [];
  }

  // Get Kelas
  static Future<List<dynamic>> fetchKelas() async {
    final data = await fetchAll();
    return data['Kelas'] ?? [];
  }

  // Get Presensi
  static Future<List<dynamic>> fetchPresensi() async {
    final data = await fetchAll();
    return data['presensi'] ?? [];
  }

  // Get Transaksi
  static Future<List<dynamic>> fetchTransaksi() async {
    final data = await fetchAll();
    return data['transaksi'] ?? [];
  }

  // Tambah siswa
  static Future<Map<String, dynamic>> tambahSiswa(
    Map<String, dynamic> data,
  ) async {
    try {
      print('🔍 Sending data to API: $data');

      final response = await http.post(
        Uri.parse(baseUrl),
        body: {'action': 'tambah_siswa', ...data},
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      print('📡 Status Code: ${response.statusCode}');
      print('📄 Content Type: ${response.headers['content-type']}');
      print('📄 Response Length: ${response.body.length} characters');
      print('📄 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final res = json.decode(response.body);
          print('✅ JSON parsed successfully: $res');
          return {
            'success': res['success'] == true,
            'message': res['message'] ?? 'No message',
            'data': res,
          };
        } catch (parseError) {
          print('❌ Error parsing JSON: $parseError');
          print('📄 Full response body: ${response.body}');
          return {
            'success': false,
            'message': 'Failed to parse JSON response',
            'error': parseError.toString(),
          };
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        print('📄 Error response body: ${response.body}');
        return {
          'success': false,
          'message': 'HTTP Error: ${response.statusCode}',
          'response': response.body,
        };
      }
    } catch (e) {
      print('💥 Network Error: $e');
      return {'success': false, 'message': 'Network Error: $e'};
    }
  }

  // Tambah transaksi
  static Future<bool> tambahTransaksi(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: {'action': 'tambah_transaksi', ...data},
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      if (response.statusCode == 200) {
        try {
          final res = json.decode(response.body);
          return res['success'] == true;
        } catch (parseError) {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Tambah/Edit/Hapus data bisa ditambah sesuai kebutuhan (POST/DELETE)
}
