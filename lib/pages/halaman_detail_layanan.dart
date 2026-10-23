import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pengajuan_cubit.dart';

class HalamanDetailLayanan extends StatefulWidget {
  final Map<String, String>? dataLayanan;

  const HalamanDetailLayanan({super.key, this.dataLayanan});

  @override
  State<HalamanDetailLayanan> createState() => _HalamanDetailLayananState();
}

class _HalamanDetailLayananState extends State<HalamanDetailLayanan> {
  bool _sedangMengirim = false;

  void _prosesPengajuan(String nama, Map<String, String> data) async {
    setState(() {
      _sedangMengirim = true;
    });

    // Simulasi proses pengiriman singkat sesaat
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    // Tambahkan ke state PengajuanCubit
    context.read<PengajuanCubit>().tambahPengajuan(data);

    setState(() {
      _sedangMengirim = false;
    });

    // Pop dan kirimkan return value ke halaman sebelumnya
    Navigator.pop(
      context,
      'Permohonan "$nama" telah berhasil diajukan.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final nama = widget.dataLayanan?['nama'] ?? 'Layanan Tidak Ditemukan';
    final dinas = widget.dataLayanan?['dinas'] ?? '-';
    final jam = widget.dataLayanan?['jam'] ?? '-';
    final keterangan = widget.dataLayanan?['keterangan'] ?? '-';

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
                icon: _sedangMengirim
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(_sedangMengirim ? 'Sedang Mengirim...' : 'Ajukan Permohonan'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _sedangMengirim
                    ? null
                    : () {
                        if (widget.dataLayanan != null) {
                          _prosesPengajuan(nama, widget.dataLayanan!);
                        }
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}