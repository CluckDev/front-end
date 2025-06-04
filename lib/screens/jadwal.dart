// lib/screens/jadwal.dart
import 'package:flutter/material.dart';
import 'tambah_jadwal.dart';
import '../models/jadwal.dart';

class JadwalScreen extends StatefulWidget {
  const JadwalScreen({super.key});

  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  List<Jadwal> daftarJadwal = [];
  DateTime? selectedFilterDate;

  void _navigateToTambahJadwal() async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TambahJadwalScreen()),
    );

    if (hasil != null && hasil is Jadwal) {
      setState(() {
        daftarJadwal.add(hasil);
      });
    }
  }

  void _editJadwal(int index) async {
    final jadwalLama = daftarJadwal[index];
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TambahJadwalScreen(editJadwal: jadwalLama),
      ),
    );

    if (hasil != null && hasil is Jadwal) {
      setState(() {
        daftarJadwal[index] = hasil;
      });
    }
  }

  void _hapusJadwal(int index) {
    setState(() {
      daftarJadwal.removeAt(index);
    });
  }

  IconData _getAktivitasIcon(String aktivitas) {
    switch (aktivitas) {
      case 'Panen':
        return Icons.agriculture;
      case 'Vaksin':
        return Icons.healing;
      case 'Pemberian Pakan':
        return Icons.restaurant;
      default:
        return Icons.event_note;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredJadwal = selectedFilterDate == null
        ? daftarJadwal
        : daftarJadwal
            .where((jadwal) => jadwal.tanggal.toLocal().toString().split(" ")[0] == selectedFilterDate!.toString().split(" ")[0])
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Hari Ini'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2030),
              );
              if (date != null) {
                setState(() {
                  selectedFilterDate = date;
                });
              }
            },
          ),
          if (selectedFilterDate != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  selectedFilterDate = null;
                });
              },
            ),
        ],
      ),
      body: filteredJadwal.isEmpty
          ? const Center(child: Text('Belum ada jadwal ditambahkan.'))
          : ListView.builder(
              itemCount: filteredJadwal.length,
              itemBuilder: (context, index) {
                final jadwal = filteredJadwal[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(_getAktivitasIcon(jadwal.aktivitas), color: Colors.green),
                    title: Text('${jadwal.aktivitas} - ${jadwal.waktu}'),
                    subtitle: Text(
                      '${jadwal.tanggal.toLocal().toString().split(" ")[0]}\n${jadwal.catatan}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _editJadwal(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _hapusJadwal(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToTambahJadwal,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// Penyesuaian untuk tambah_jadwal.dart akan menyusul agar mendukung mode edit
