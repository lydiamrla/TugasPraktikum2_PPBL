import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_warga.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
  ];

  final List<String> _judul = const [
    'Beranda Smart City',
    'Layanan Publik',
    'Profil & Identitas Warga',
  ];

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  Widget _buatIkonWarga({required bool selected}) {
    final iconBase = Icon(selected ? Icons.person : Icons.person_outline);
    return BlocSelector<PengajuanCubit, List<Map<String, String>>, int>(
      selector: (state) => state.length,
      builder: (context, total) {
        if (total == 0) return iconBase;
        return Badge(
          label: Text('$total'),
          child: iconBase,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double lebar = MediaQuery.of(context).size.width;
    final bool layarLebar = lebar >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(_judul[_indeksTerpilih]),
        elevation: 2,
        actions: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              final isDark = themeMode == ThemeMode.dark;
              return IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                tooltip: isDark ? 'Ganti ke Mode Terang' : 'Ganti ke Mode Gelap',
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      drawer: _buatDrawer(),
      body: layarLebar ? _tataLetakLebar() : _halaman[_indeksTerpilih],
      bottomNavigationBar: layarLebar ? null : _buatBilahBawah(),
    );
  }

  Widget _buatBilahBawah() {
    return NavigationBar(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: _pilihTujuan,
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.location_city_outlined),
          selectedIcon: Icon(Icons.location_city),
          label: 'Beranda',
        ),
        const NavigationDestination(
          icon: Icon(Icons.grid_view_outlined),
          selectedIcon: Icon(Icons.grid_view),
          label: 'Layanan',
        ),
        NavigationDestination(
          icon: _buatIkonWarga(selected: false),
          selectedIcon: _buatIkonWarga(selected: true),
          label: 'Warga',
        ),
      ],
    );
  }

  Widget _tataLetakLebar() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _indeksTerpilih,
          onDestinationSelected: _pilihTujuan,
          extended: true,
          leading: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Icon(Icons.apartment, size: 36),
          ),
          destinations: [
            const NavigationRailDestination(
              icon: Icon(Icons.location_city_outlined),
              selectedIcon: Icon(Icons.location_city),
              label: Text('Beranda'),
            ),
            const NavigationRailDestination(
              icon: Icon(Icons.grid_view_outlined),
              selectedIcon: Icon(Icons.grid_view),
              label: Text('Layanan'),
            ),
            NavigationRailDestination(
              icon: _buatIkonWarga(selected: false),
              selectedIcon: _buatIkonWarga(selected: true),
              label: Text('Warga'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(child: _halaman[_indeksTerpilih]),
      ],
    );
  }

  Widget _buatDrawer() {
    return NavigationDrawer(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: (indeks) {
        if (indeks < 3) {
          _pilihTujuan(indeks);
          Navigator.pop(context);
        }
      },
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text('Lydia Marla Tadung'),
          accountEmail: Text('mrla@nusantara.go.id'),
          currentAccountPicture: CircleAvatar(
            child: Icon(Icons.person, size: 36),
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.location_city_outlined),
          selectedIcon: Icon(Icons.location_city),
          label: Text('Beranda'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.grid_view_outlined),
          selectedIcon: Icon(Icons.grid_view),
          label: Text('Layanan'),
        ),
        NavigationDrawerDestination(
          icon: _buatIkonWarga(selected: false),
          selectedIcon: _buatIkonWarga(selected: true),
          label: const Text('Warga'),
        ),
        const Divider(indent: 28, endIndent: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
          child: Text(
            'Menu Pendukung',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Pengaturan Kota'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.pengaturan);
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Tentang Aplikasi'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.tentang);
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('Keluar', style: TextStyle(color: Colors.red)),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sesi berhasil diakhiri.')),
            );
          },
        ),
      ],
    );
  }
}