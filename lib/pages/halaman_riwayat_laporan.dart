import 'package:flutter/material.dart';

class HalamanRiwayatLaporan extends StatelessWidget {
  const HalamanRiwayatLaporan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Laporan Warga'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.warning_amber, color: Colors.orange),
              title: Text('Jalan Berlubang di Jl. Nusantara No. 12'),
              subtitle: Text('Status: Diproses oleh Dinas PU • 12 Mei 2026'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Permohonan Izin Usaha Mikro'),
              subtitle: Text('Status: Selesai • 10 Mei 2026'),
            ),
          ),
        ],
      ),
      // ===== BOTTOM APP BAR DENGAN FAB DI TENGAH =====
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {},
              tooltip: 'Filter Status',
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
              tooltip: 'Cari Laporan',
            ),
            const Spacer(), // <--- Memberi ruang kosong tepat di tengah untuk tombol +
            IconButton(
              icon: const Icon(Icons.print),
              onPressed: () {},
              tooltip: 'Cetak Riwayat',
            ),
          ],
        ),
      ),
      // ===== UBAH LOKASI JADI CENTER DOCKED =====
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fitur Tambah Laporan Baru dibuka.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        tooltip: 'Tambah Laporan',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // <--- UBAH DI SINI
    );
  }
}