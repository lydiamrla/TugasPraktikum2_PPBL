import 'package:flutter/material.dart';

class HalamanTidakDikenal extends StatelessWidget {
  final String? namaRoute;

  const HalamanTidakDikenal({super.key, this.namaRoute});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Tidak Dikenal'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 80, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                '404 - Halaman Tidak Ditemukan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Route "${namaRoute ?? '-'}" tidak terdaftar pada aplikasi.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () { // <--- DI-PERBAIKI: Mengubah onTap menjadi onPressed
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}