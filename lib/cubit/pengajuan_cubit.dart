import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanCubit extends Cubit<List<Map<String, String>>> {
  PengajuanCubit() : super([]);

  int get totalPengajuan => state.length;

  void tambahPengajuan(Map<String, String> layanan) {
    final daftarBaru = List<Map<String, String>>.from(state)..add(layanan);
    emit(daftarBaru);
  }

  void bersihkanPengajuan() {
    emit([]);
  }
}