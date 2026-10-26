import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
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
                    Text(
                      'Lydia Marla Tadung',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('NIK: 707012400127'),
                    Text('Status: Warga Verifikasi Terintegrasi'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ===== SEKSI PENGATURAN TEMA (DARK MODE TOGGLE) =====
        Card(
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              final isDarkMode = themeMode == ThemeMode.dark;
              return SwitchListTile(
                title: const Text('Mode Gelap (Dark Theme)'),
                subtitle: Text(isDarkMode ? 'Mode gelap aktif' : 'Mode terang aktif'),
                secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
                value: isDarkMode,
                onChanged: (_) {
                  context.read<ThemeCubit>().toggleTheme();
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        // ===== SEKSI LAYANAN FAVORIT =====
        Text(
          'Layanan Favorit',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, favoritSet) {
            if (favoritSet.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Belum ada layanan yang ditandai favorit.'),
                ),
              );
            }
            return Card(
              child: Column(
                children: favoritSet.map((nama) {
                  return ListTile(
                    leading: const Icon(Icons.star, color: Colors.amber),
                    title: Text(nama),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        context.read<FavoritCubit>().batalTandai(nama);
                      },
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        // ===== SEKSI KERANJANG PENGAJUAN =====
        Text(
          'Keranjang Pengajuan',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        BlocBuilder<PengajuanCubit, List<Map<String, String>>>(
          builder: (context, pengajuanList) {
            if (pengajuanList.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Belum ada layanan dalam keranjang pengajuan.'),
                ),
              );
            }
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ...pengajuanList.map(
                      (item) => ListTile(
                        leading: const Icon(Icons.assignment_turned_in_outlined),
                        title: Text(item['nama'] ?? '-'),
                        subtitle: Text(item['dinas'] ?? '-'),
                      ),
                    ),
                    const Divider(),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      label: const Text('Kirim Semua Pengajuan'),
                      onPressed: () {
                        context.read<PengajuanCubit>().bersihkanPengajuan();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Seluruh permohonan berhasil dikirim ke dinas terkait!'),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('Riwayat Laporan & Pengajuan'),
          subtitle: const Text('Lihat status permohonan dan aduan Anda'),
          trailing: const Icon(Icons.chevron_right),
          tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.riwayatLaporan);
          },
        ),
      ],
    );
  }
}