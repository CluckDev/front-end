import 'package:flutter/material.dart';
import '../models/jadwal.dart';

class TambahJadwalScreen extends StatefulWidget {
  final Jadwal? editJadwal; // ini ditambahkan

  const TambahJadwalScreen({super.key, this.editJadwal});

  @override
  State<TambahJadwalScreen> createState() => _TambahJadwalScreenState();
}


class _TambahJadwalScreenState extends State<TambahJadwalScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String selectedAktivitas = 'Panen';
  final TextEditingController catatanController = TextEditingController();
  @override
void initState() {
  super.initState();

  if (widget.editJadwal != null) {
    final jadwal = widget.editJadwal!;
    selectedDate = jadwal.tanggal;

    // Pisahkan jam dan menit dari string waktu
    final waktuParts = jadwal.waktu.split(':');
    selectedTime = TimeOfDay(
      hour: int.tryParse(waktuParts[0]) ?? 0,
      minute: int.tryParse(waktuParts[1]) ?? 0,
    );

    selectedAktivitas = jadwal.aktivitas;
    catatanController.text = jadwal.catatan;
  }
}

  Future<void> _pickDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (!mounted) return;

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (!mounted) return;

      if (time != null) {
        setState(() {
          selectedDate = date;
          selectedTime = time;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Jadwal')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _pickDateTime,
              icon: const Icon(Icons.calendar_today),
              label: Text(
                selectedDate != null && selectedTime != null
                    ? '${selectedDate!.toLocal().toString().split(" ")[0]} - ${selectedTime!.format(context)}'
                    : 'Pilih Tanggal & Waktu',
              ),
            ),
DropdownButtonFormField<String>(
  value: selectedAktivitas,
  decoration: const InputDecoration(
    labelText: 'Aktivitas',
    border: OutlineInputBorder(),
  ),
  items: const [
    DropdownMenuItem(
      value: 'Panen',
      child: Row(
        children: [
          Icon(Icons.agriculture),
          SizedBox(width: 8),
          Text('Panen'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'Vaksin',
      child: Row(
        children: [
          Icon(Icons.healing),
          SizedBox(width: 8),
          Text('Vaksin'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'Pemberian Pakan',
      child: Row(
        children: [
          Icon(Icons.restaurant),
          SizedBox(width: 8),
          Text('Pemberian Pakan'),
        ],
      ),
    ),
  ],
  onChanged: (value) {
    setState(() {
      selectedAktivitas = value!;
    });
  },
),

            const SizedBox(height: 16),
            TextField(
              controller: catatanController,
              decoration: const InputDecoration(
                labelText: 'Catatan Tambahan',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
  if (selectedDate == null || selectedTime == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Harap pilih tanggal dan waktu terlebih dahulu')),
    );
    return;
  }

  final newJadwal = Jadwal(
    tanggal: selectedDate!,
    waktu: selectedTime!.format(context),
    aktivitas: selectedAktivitas,
    catatan: catatanController.text,
  );

  Navigator.pop(context, newJadwal); // Kirim ke JadwalScreen
},

               child: Text(widget.editJadwal != null ? 'Simpan Perubahan' : 'Tambah Jadwal'),
            
              ),
            ),
          ],
        ),
      ),
    );
  }
}
