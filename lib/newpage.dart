import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  final String? kodeBarang;
  final String? namaBarang;
  final String? jenisBarang;
  final int? hargaBarang;
  final int? stokBarang;
  final String? tglMasuk;
  final VoidCallback onOkPressed;

  const NewPage({
    super.key,
    required this.kodeBarang,
    required this.namaBarang,
    required this.jenisBarang,
    required this.hargaBarang,
    required this.stokBarang,
    required this.tglMasuk,
    required this.onOkPressed
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text("Rekap Tambah Data Barang"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(3.0), // Mengatur lebar kolom label
                1: FixedColumnWidth(10.0), // Lebar untuk titik dua, disesuaikan
                2: FlexColumnWidth(4.0), // Mengatur lebar kolom nilai
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                _buildTableRow("Kode Barang", kodeBarang ?? "-"),
                _buildTableRow("Nama Barang", namaBarang ?? "-"),
                _buildTableRow("Jenis Barang", jenisBarang ?? "-"),
                _buildTableRow("Harga Barang/Item", hargaBarang != null ? "Rp.${hargaBarang.toString()}" : "-"),
                _buildTableRow("Stok Barang", stokBarang != null ? stokBarang.toString() : "-"),
                _buildTableRow("Tanggal Masuk", tglMasuk ?? "-"),
              ],
            ),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onOkPressed();
                  },
                  // Kembali ke halaman sebelumnya
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(":"), // Titik dua
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(value), // Nilai
        ),
      ],
    );
  }
}
