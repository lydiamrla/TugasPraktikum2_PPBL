import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: const Center(
        child: Text(
          'Nusantara Cerdas Mobile v2.0\nDiskominfo Kota Nusantara',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}