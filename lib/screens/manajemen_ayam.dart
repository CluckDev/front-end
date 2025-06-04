import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tambah_data_screen.dart';

class ManajemenAyamScreen extends StatefulWidget {
  const ManajemenAyamScreen({super.key});

  @override
  State<ManajemenAyamScreen> createState() => _ManajemenAyamScreenState();
}

class _ManajemenAyamScreenState extends State<ManajemenAyamScreen> {
  String activePeriod = 'Harian';

  final Map<String, List<Map<String, dynamic>>> dataRingkasan = {
    'Harian': [
      {'label': 'Ayam', 'icon': Icons.pets, 'jumlah': 2000, 'waktu': '08:00 - 20 April', 'ringkasan': 'Masuk: 1500'},
      {'label': 'Ayam', 'icon': Icons.pets, 'jumlah': 10, 'waktu': '08:00 - 20 April', 'ringkasan': 'Sakit: 10'},
    ],
    'Mingguan': [
      {'label': 'Ayam', 'icon': Icons.pets, 'jumlah': 12000, 'waktu': 'Minggu ke-3 April', 'ringkasan': 'Masuk: 8000'},
      {'label': 'Ayam', 'icon': Icons.pets, 'jumlah': 50, 'waktu': 'Minggu ke-3 April', 'ringkasan': 'Sakit: 50'},
    ],
    'Bulanan': [
      {'label': 'Ayam', 'icon': Icons.pets, 'jumlah': 48000, 'waktu': 'April 2025', 'ringkasan': 'Masuk: 32000'},
      {'label': 'Ayam', 'icon': Icons.pets, 'jumlah': 200, 'waktu': 'April 2025', 'ringkasan': 'Sakit: 200'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Ayam'),
        backgroundColor: Colors.green[700],
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          // Grafik dummy sesuai tab aktif
          Container(
            height: 200,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Grafik Produksi Ayam - $activePeriod',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
          ),

          // Tab filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tabFilter('Harian'),
                _tabFilter('Mingguan'),
                _tabFilter('Bulanan'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // List ringkasan sesuai tab aktif
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dataRingkasan[activePeriod]!.length,
              itemBuilder: (context, index) {
                final item = dataRingkasan[activePeriod]![index];
                return _RingkasanItem(
                  label: item['label'],
                  icon: item['icon'],
                  jumlah: item['jumlah'],
                  waktu: item['waktu'],
                  ringkasan: item['ringkasan'],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[700],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahDataScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _tabFilter(String label) {
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
      ),
      child: Text(label, style: GoogleFonts.poppins(color: Colors.white)),
    );
  }
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
          // Kiri (ikon + label + waktu)
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
