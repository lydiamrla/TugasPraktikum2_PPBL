import 'package:flutter/material.dart';

class HalamanDetailLayanan extends StatelessWidget {
  final Map<String, dynamic>? dataLayanan;

  const HalamanDetailLayanan({super.key, this.dataLayanan});

  @override
  Widget build(BuildContext context) {
    final nama = dataLayanan?['nama'] ?? 'Layanan Tidak Ditemukan';
    final dinas = dataLayanan?['dinas'] ?? '-';
    final jam = dataLayanan?['jam'] ?? '-';
    final keterangan = dataLayanan?['keterangan'] ?? '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Layanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nama,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Chip(
              label: Text(dinas),
              avatar: const Icon(Icons.account_balance, size: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              'Jam Operasional:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(jam),
            const SizedBox(height: 16),
            const Text(
              'Keterangan Singkat:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(keterangan),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Ajukan Permohonan'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () { // <--- DI-PERBAIKI: Mengubah onTap menjadi onPressed
                  Navigator.pop(
                    context,
                    'Permohonan "$nama" telah berhasil diajukan.',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}