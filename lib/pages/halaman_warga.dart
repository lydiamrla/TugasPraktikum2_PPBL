import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    child: Icon(Icons.person, size: 40),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lydia Marla Tadung', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('NIK: 707012400127'),
                      Text('Status: Warga Verifikasi Terintegrasi'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Riwayat Laporan & Pengajuan'),
            subtitle: const Text('Lihat status permohonan dan aduan Anda'),
            trailing: const Icon(Icons.chevron_right),
            tileColor: Theme.of(context).colorScheme.surfaceVariant,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.riwayatLaporan);
            },
          ),
        ],
      ),
    );
  }
}