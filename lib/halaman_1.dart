import 'package:flutter/material.dart';

class HalamanSatu extends StatelessWidget {
  const HalamanSatu({super.key});

  final List<Map<String, dynamic>> coffeeMenu = const [
    {
      'name': 'Indocafe Mix',
      'desc': 'Kopi dan Susu',
      'price': 5000,
      'image': null,
    },
    {
      'name': 'Good Day Cappuccino',
      'desc': 'Espresso, susu, dan foam lembut.',
      'price': 8000,
      'image': null,
    },
    {
      'name': 'Kopi Abc Klepon',
      'desc': 'Kopi dengan perpaduan kelapa yang nikmat.',
      'price': 9000,
      'image': null,
    },
    {
      'name': 'Kopi Liong Bulan',
      'desc': 'Kopi tradisional dengan aroma dan rasa yang nikmat.',
      'price': 5000,
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
              width: 120,
              height: 120,
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
