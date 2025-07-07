import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DebugApiPage extends StatefulWidget {
  const DebugApiPage({super.key});

  @override
  State<DebugApiPage> createState() => _DebugApiPageState();
}

class _DebugApiPageState extends State<DebugApiPage> {
  String _logResult = '';
  bool _isLoading = false;

  void _addLog(String message) {
    setState(() {
      _logResult +=
          '${DateTime.now().toString().substring(11, 19)}: $message\n';
    });
  }

  Future<void> _testGetApi() async {
    setState(() {
      _isLoading = true;
    });

    _addLog('🔍 Testing GET API...');

    try {
      final response = await http.get(Uri.parse('http://10.0.2.2/api.php'));

      _addLog('📡 Status Code: ${response.statusCode}');
      _addLog('📄 Content Type: ${response.headers['content-type']}');
      _addLog('📄 Response Length: ${response.body.length} characters');
      _addLog(
        '📄 First 500 chars: ${response.body.substring(0, response.body.length > 500 ? 500 : response.body.length)}',
      );

      if (response.statusCode == 200) {
        try {
          final jsonData = json.decode(response.body);
          _addLog('✅ JSON parsed successfully');
          _addLog('📊 JSON keys: ${jsonData.keys.toList()}');
        } catch (e) {
          _addLog('❌ JSON parse error: $e');
          _addLog('📄 Full response: ${response.body}');
        }
      } else {
        _addLog('❌ HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      _addLog('💥 Network Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testPostSiswa() async {
    setState(() {
      _isLoading = true;
    });

    _addLog('🔍 Testing POST tambah_siswa...');

    try {
      final testData = {
        'action': 'tambah_siswa',
        'NIK': 'TEST${DateTime.now().millisecondsSinceEpoch}',
        'NAMA': 'Test Siswa',
        'ALAMAT': 'Test Alamat',
        'JENIS_KELAMIN': 'L',
        'TTL': 'Test TTL',
        'KELAS': 'Test Kelas',
      };

      _addLog('📤 Sending data: $testData');

      final response = await http.post(
        Uri.parse('http://10.0.2.2/api.php'),
        body: testData,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      _addLog('📡 Status Code: ${response.statusCode}');
      _addLog('📄 Content Type: ${response.headers['content-type']}');
      _addLog('📄 Response: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final jsonData = json.decode(response.body);
          _addLog('✅ JSON parsed successfully');
          _addLog('📊 Response: $jsonData');
        } catch (e) {
          _addLog('❌ JSON parse error: $e');
        }
      } else {
        _addLog('❌ HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      _addLog('💥 Network Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _clearLog() {
    setState(() {
      _logResult = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug API'),
        backgroundColor: const Color(0xFF5B7FFF),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearLog,
            tooltip: 'Clear Log',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _testGetApi,
                    child: const Text('Test GET'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _testPostSiswa,
                    child: const Text('Test POST Siswa'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black87,
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _logResult.isEmpty
                        ? 'Log akan muncul di sini...'
                        : _logResult,
                    style: const TextStyle(
                      color: Colors.green,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
