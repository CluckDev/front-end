import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/dashboard_chart.dart';
import 'jadwal.dart';
import 'manajemen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardContent(),
    JadwalScreen(),
    ManajemenScreen(),
    Center(child: Text('Halaman Profil')),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}

// Widget utama untuk konten dashboard
class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          DashboardHeader(),
          SizedBox(height: 16),
          StatistikSection(title: 'Statistik Produksi Telur'),
          StatistikSection(title: 'Statistik Produksi Ayam'),
          StatistikSection(title: 'Statistik Pakan'),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

// Widget header (bagian selamat datang + ringkasan)
class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade700,
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat datang\nHallo, Reza',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              SummaryCard(label: 'Telur', value: '100', icon: Icons.egg),
              SummaryCard(label: 'Ayam', value: '40', icon: Icons.pets),
              SummaryCard(label: 'Pakan', value: '20kg', icon: Icons.rice_bowl),
              SummaryCard(label: 'Sakit', value: '20', icon: Icons.warning),
            ],
          ),
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const SummaryCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            Icon(icon, color: Colors.green.shade700, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatistikSection extends StatefulWidget {
  final String title;

  const StatistikSection({super.key, required this.title});

  @override
  State<StatistikSection> createState() => _StatistikSectionState();
}

class _StatistikSectionState extends State<StatistikSection>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              widget.title,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.green.shade700,
            indicatorWeight: 3,
            labelColor: Colors.green.shade700,
            labelStyle: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Harian'),
              Tab(text: 'Mingguan'),
              Tab(text: 'Bulanan'),
            ],
          ),
          SizedBox(
            height: 200,
            child: TabBarView(
              controller: _tabController,
              children: const [
                DashboardChart(period: 'daily'),
                DashboardChart(period: 'weekly'),
                DashboardChart(period: 'monthly'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
