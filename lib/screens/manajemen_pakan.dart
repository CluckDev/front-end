import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tambah_data_screen.dart';

class ManajemenPakanScreen extends StatefulWidget {
  const ManajemenPakanScreen({super.key});

  @override
  State<ManajemenPakanScreen> createState() => _ManajemenPakanScreenState();
}

class _ManajemenPakanScreenState extends State<ManajemenPakanScreen> {
  String activePeriod = 'Harian';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Pakan'),
        backgroundColor: Colors.green[700],
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          // Chart dummy yang berubah sesuai tab aktif
          Container(
            height: 200,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Grafik Produksi Pakan - $activePeriod',
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

          // List ringkasan dengan style mirip manajemen_ayam.dart
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                _RingkasanItem(
                  label: 'Jagung',
                  icon: Icons.rice_bowl,
                  jumlah: 100,
                  satuan: 'kg',
                  waktu: '08:00 - 20 April',
                  ringkasan: 'Keluar 50 kg',
                ),
                _RingkasanItem(
                  label: 'Konsentrat',
                  icon: Icons.rice_bowl,
                  jumlah: 40,
                  satuan: 'kg',
                  waktu: '08:00 - 20 April',
                  ringkasan: ' Masuk: 10 kg',
                ),
              ],
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
  final String satuan;
  final String waktu;
  final String ringkasan;

  const _RingkasanItem({
    required this.label,
    required this.icon,
    required this.jumlah,
    required this.satuan,
    required this.waktu,
    required this.ringkasan,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Kiri (ikon + label + waktu)
          Expanded(
            flex: 3,
            child: Row(
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

          // Garis vertikal
          Container(
            width: 1,
            height: 40,
            color: Colors.grey[400],
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),

          // Tengah (ringkasan)
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

          // Garis vertikal
          Container(
            width: 1,
            height: 40,
            color: Colors.grey[400],
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),

          // Kanan (jumlah + satuan)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Jumlah', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text('$jumlah $satuan', style: GoogleFonts.poppins(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
