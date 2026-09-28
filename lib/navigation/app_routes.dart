import 'package:flutter/material.dart';
import '../pages/halaman_detail_layanan.dart';
import '../pages/halaman_riwayat_laporan.dart';
import '../pages/halaman_pengaturan.dart';
import '../pages/halaman_tentang.dart';
import '../pages/halaman_tidak_dikenal.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detailLayanan = '/detail-layanan';
  static const String riwayatLaporan = '/riwayat-laporan';
  static const String pengaturan = '/pengaturan';
  static const String tentang = '/tentang';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      riwayatLaporan: (context) => const HalamanRiwayatLaporan(),
      pengaturan: (context) => const HalamanPengaturan(),
      tentang: (context) => const HalamanTentang(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailLayanan) {
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute(
        builder: (context) => HalamanDetailLayanan(dataLayanan: args),
      );
    }
    return null;
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => HalamanTidakDikenal(namaRoute: settings.name),
    );
  }
}