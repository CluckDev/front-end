import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'manajemen_ayam.dart';
import 'manajemen_telur.dart';
import 'manajemen_pakan.dart';
import 'manajemen_kesehatan.dart';

class ManajemenScreen extends StatefulWidget {
  const ManajemenScreen({super.key});

  @override
  State<ManajemenScreen> createState() => _ManajemenScreenState();
}

class _ManajemenScreenState extends State<ManajemenScreen> {
  String activePeriod = 'Harian';

  // Data ringkasan untuk setiap periode
  final Map<String, List<_RingkasanData>> dataPeriode = {
    'Harian': [
      _RingkasanData('Ayam', Icons.pets, 2000, '08:00 - 20 April', 'Masuk: 1500'),
      _RingkasanData('Telur', Icons.egg, 1500, '08:00 - 20 April', 'Masuk: 2000'),
      _RingkasanData('Pakan', Icons.rice_bowl, 20, '08:00 - 20 April', 'Masuk: Jagung 20 kg'),
      _RingkasanData('Kesehatan', Icons.health_and_safety, 5, '08:00 - 20 April', 'Ayam sakit: 5 ekor'),
    ],
    'Mingguan': [
      _RingkasanData('Ayam', Icons.pets, 14000, 'Minggu ini', 'Masuk: 10500'),
      _RingkasanData('Telur', Icons.egg, 10500, 'Minggu ini', 'Masuk: 14000'),
      _RingkasanData('Pakan', Icons.rice_bowl, 140, 'Minggu ini', 'Masuk: Jagung 140 kg'),
      _RingkasanData('Kesehatan', Icons.health_and_safety, 35, 'Minggu ini', 'Ayam sakit: 35 ekor'),
    ],
    'Bulanan': [
      _RingkasanData('Ayam', Icons.pets, 60000, 'Bulan ini', 'Masuk: 45000'),
      _RingkasanData('Telur', Icons.egg, 45000, 'Bulan ini', 'Masuk: 60000'),
      _RingkasanData('Pakan', Icons.rice_bowl, 600, 'Bulan ini', 'Masuk: Jagung 600 kg'),
      _RingkasanData('Kesehatan', Icons.health_and_safety, 150, 'Bulan ini', 'Ayam sakit: 150 ekor'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final ringkasanList = dataPeriode[activePeriod]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen'),
        backgroundColor: Colors.green[700],
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          // Bagian atas tombol kategori
          Container(
            color: Colors.green[100],
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _iconButton(context, Icons.pets, 'Ayam', const ManajemenAyamScreen()),
                _iconButton(context, Icons.egg, 'Telur', const ManajemenTelurScreen()),
                _iconButton(context, Icons.rice_bowl, 'Pakan', const ManajemenPakanScreen()),
                _iconButton(context, Icons.health_and_safety, 'Kesehatan', const ManajemenKesehatanScreen()),
              ],
            ),
          ),

          // Tab filter Harian, Mingguan, Bulanan
          Container(
            color: Colors.green[50],
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _tabFilterButton('Harian'),
                const SizedBox(width: 8),
                _tabFilterButton('Mingguan'),
                const SizedBox(width: 8),
                _tabFilterButton('Bulanan'),
              ],
            ),
          ),

          // List ringkasan sesuai tab aktif
          Expanded(
            child: Container(
              color: Colors.green[50],
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: ringkasanList.length,
                itemBuilder: (context, index) {
                  final item = ringkasanList[index];
                  return _RingkasanItem(
                    label: item.label,
                    icon: item.icon,
                    jumlah: item.jumlah,
                    waktu: item.waktu,
                    ringkasan: item.ringkasan,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabFilterButton(String label) {
    final bool isActive = activePeriod == label;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          activePeriod = label;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.green[700] : Colors.green[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
      child: Text(label, style: GoogleFonts.poppins(color: Colors.white)),
    );
  }

  Widget _iconButton(BuildContext context, IconData icon, String label, Widget page) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.poppins(fontSize: 12)),
      ],
    );
  }
}

class _RingkasanData {
  final String label;
  final IconData icon;
  final int jumlah;
  final String waktu;
  final String ringkasan;

  _RingkasanData(this.label, this.icon, this.jumlah, this.waktu, this.ringkasan);
}

class _RingkasanItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final int jumlah;
  final String waktu;
  final String ringkasan;

  const _RingkasanItem({
    required this.label,
    required this.icon,
    required this.jumlah,
    required this.waktu,
    required this.ringkasan,
  });

  @override
  Widget build(BuildContext context) {
    String jumlahText = label == 'Pakan' ? '$jumlah kg' : '$jumlah';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Kiri (ikon + label), rata kiri
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.green[700], size: 28),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(waktu, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ],
            ),
          ),

          // Garis vertikal antara kiri dan tengah
          Container(
            width: 1,
            height: 40,
            color: Colors.grey[400],
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),

          // Tengah (ringkasan), rata tengah
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                ringkasan,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Garis vertikal antara tengah dan kanan
          Container(
            width: 1,
            height: 40,
            color: Colors.grey[400],
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),

          // Kanan (jumlah), rata kanan
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Jumlah', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text(jumlahText, style: GoogleFonts.poppins(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
