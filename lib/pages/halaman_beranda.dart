import 'package:flutter/material.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  final List<Map<String, dynamic>> pilarSmartCity = const [
    {'nama': 'Smart Governance', 'ikon': Icons.gavel, 'deskripsi': 'Pelayanan publik transparan & efisien'},
    {'nama': 'Smart Economy', 'ikon': Icons.store, 'deskripsi': 'Pemberdayaan UMKM & ekonomi digital'},
    {'nama': 'Smart Environment', 'ikon': Icons.eco, 'deskripsi': 'Pengelolaan sampah & energi hijau'},
    {'nama': 'Smart Living', 'ikon': Icons.health_and_safety, 'deskripsi': 'Kesehatan, keamanan & kebudayaan'},
    {'nama': 'Smart People', 'ikon': Icons.school, 'deskripsi': 'Pendidikan & literasi digital warga'},
    {'nama': 'Smart Mobility', 'ikon': Icons.directions_bus, 'deskripsi': 'Transportasi terintegrasi & ramah lingkungan'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '6 Pilar Nusantara Cerdas',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: pilarSmartCity.length,
              itemBuilder: (context, index) {
                final pilar = pilarSmartCity[index];
                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(pilar['ikon'] as IconData, size: 40, color: Theme.of(context).primaryColor),
                        const SizedBox(height: 8),
                        Text(
                          pilar['nama'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pilar['deskripsi'] as String,
                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}