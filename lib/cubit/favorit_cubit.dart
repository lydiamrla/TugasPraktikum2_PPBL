import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super({});

  void tandai(String namaLayanan) {
    final himpunanBaru = Set<String>.from(state)..add(namaLayanan);
    emit(himpunanBaru);
  }

  void batalTandai(String namaLayanan) {
    final himpunanBaru = Set<String>.from(state)..remove(namaLayanan);
    emit(himpunanBaru);
  }

  void toggleFavorit(String namaLayanan) {
    if (state.contains(namaLayanan)) {
      batalTandai(namaLayanan);
    } else {
      tandai(namaLayanan);
    }
  }
}