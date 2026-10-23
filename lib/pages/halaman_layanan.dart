import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';
import '../navigation/app_routes.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  final List<Map<String, String>> perizinan = const [
    {
      'nama': 'Izin Usaha Mikro (IUMK)',
      'dinas': 'Dinas Penanaman Modal & PTSP',
      'jam': '08.00 - 15.00 WIB',
      'keterangan': 'Penerbitan legalitas usaha skala mikro dan kecil bagi warga kota.'
    },
    {
      'nama': 'Izin Mendirikan Bangunan (IMB)',
      'dinas': 'Dinas Pekerjaan Umum & Tata Ruang',
      'jam': '08.00 - 14.00 WIB',
      'keterangan': 'Pengurusan persetujuan bangunan gedung hunian maupun komersial.'
    },
    {
      'nama': 'Izin Keramaian & Acara',
      'dinas': 'Dinas Perhubungan & Satpol PP',
      'jam': '24 Jam (Online)',
      'keterangan': 'Permohonan izin penyelenggaraan kegiatan masyarakat terbuka.'
    },
  ];

  final List<Map<String, String>> kesehatan = const [
    {
      'nama': 'Pendaftaran Puskesmas Online',
      'dinas': 'Dinas Kesehatan',
      'jam': '07.30 - 12.00 WIB',
      'keterangan': 'Pemesanan nomor antrean rawat jalan puskesmas se-Kota Nusantara.'
    },
    {
      'nama': 'Layanan Ambulans Darurat 112',
      'dinas': 'Dinas Kesehatan & BPBD',
      'jam': '24 Jam Nonstop',
      'keterangan': 'Penanganan penjemputan medis darurat untuk warga kota.'
    },
    {
      'nama': 'Sertifikasi Laik Higiene Sanitasi',
      'dinas': 'Dinas Kesehatan',
      'jam': '08.00 - 15.00 WIB',
      'keterangan': 'Pemeriksaan kelayakan sanitasi untuk usaha kuliner dan rumah makan.'
    },
  ];

  final List<Map<String, String>> transportasi = const [
    {
      'nama': 'Kartu Berlangganan Bus TransNusantara',
      'dinas': 'Dinas Perhubungan',
      'jam': '06.00 - 18.00 WIB',
      'keterangan': 'Pengajuan kartu bus gratis bagi pelajar, mahasiswa, dan lansia.'
    },
    {
      'nama': 'Uji Berkala Kendaraan (KIR)',
      'dinas': 'Dinas Perhubungan',
      'jam': '08.00 - 14.30 WIB',
      'keterangan': 'Pendaftaran pemeriksaan kelaikan jalan armada angkutan barang/umum.'
    },
    {
      'nama': 'Laporan Kendala Lalu Lintas',
      'dinas': 'Dinas Perhubungan & Dishubtech',
      'jam': '24 Jam',
      'keterangan': 'Pelaporan lampu lalu lintas padam, kemacetan, dan marka rusak.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.assignment), text: 'Perizinan'),
              Tab(icon: Icon(Icons.local_hospital), text: 'Kesehatan'),
              Tab(icon: Icon(Icons.directions_bus), text: 'Transportasi'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buatDaftar(context, perizinan),
                _buatDaftar(context, kesehatan),
                _buatDaftar(context, transportasi),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buatDaftar(BuildContext context, List<Map<String, String>> items) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        final nama = item['nama']!;

        return BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, favoritSet) {
            final isFavorit = favoritSet.contains(nama);

            return ListTile(
              leading: IconButton(
                icon: Icon(
                  isFavorit ? Icons.star : Icons.star_border,
                  color: isFavorit ? Colors.amber : null,
                ),
                onPressed: () {
                  context.read<FavoritCubit>().toggleFavorit(nama);
                },
              ),
              title: Text(nama),
              subtitle: Text(item['dinas']!),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final hasil = await Navigator.pushNamed(
                  context,
                  AppRoutes.detailLayanan,
                  arguments: item,
                );
                if (hasil != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(hasil.toString()),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green[700],
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}