import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MODEL DATA PERLENGKAPAN KULIAH
class Perlengkapan {
  final String nama;
  final String kategori;
  final int jumlah;
  final bool wajib;
  final IconData ikon;
  bool sudahSiap;

  Perlengkapan({
    required this.nama,
    required this.kategori,
    required this.jumlah,
    required this.wajib,
    required this.ikon,
    this.sudahSiap = false,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReadyKuliah',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5856A6),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F5FC),
          foregroundColor: Color(0xFF29284F),
          centerTitle: false,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5856A6),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const HalamanUtama(),
    );
  }
}

// HALAMAN UTAMA
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  final List<Perlengkapan> daftarBarang = [
    Perlengkapan(
      nama: 'Laptop',
      kategori: 'Perangkat elektronik',
      jumlah: 1,
      wajib: true,
      ikon: Icons.laptop_mac,
    ),
    Perlengkapan(
      nama: 'Charger',
      kategori: 'Perangkat elektronik',
      jumlah: 1,
      wajib: true,
      ikon: Icons.battery_charging_full,
    ),
    Perlengkapan(
      nama: 'Buku catatan',
      kategori: 'Alat tulis',
      jumlah: 2,
      wajib: true,
      ikon: Icons.menu_book,
    ),
    Perlengkapan(
      nama: 'Pulpen',
      kategori: 'Alat tulis',
      jumlah: 2,
      wajib: true,
      ikon: Icons.edit,
    ),
    Perlengkapan(
      nama: 'Kartu mahasiswa',
      kategori: 'Identitas',
      jumlah: 1,
      wajib: true,
      ikon: Icons.badge_outlined,
    ),
    Perlengkapan(
      nama: 'Botol minum',
      kategori: 'Kebutuhan pribadi',
      jumlah: 1,
      wajib: false,
      ikon: Icons.water_drop_outlined,
    ),
    Perlengkapan(
      nama: 'Earphone',
      kategori: 'Perangkat elektronik',
      jumlah: 1,
      wajib: false,
      ikon: Icons.headphones,
    ),
  ];

  int get jumlahSiap =>
      daftarBarang.where((barang) => barang.sudahSiap).length;

  int get jumlahWajib =>
      daftarBarang.where((barang) => barang.wajib).length;

  int get jumlahWajibSiap => daftarBarang
      .where((barang) => barang.wajib && barang.sudahSiap)
      .length;

  double get persentaseKesiapan =>
      daftarBarang.isEmpty ? 0 : jumlahSiap / daftarBarang.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.backpack_outlined, size: 28),
            SizedBox(width: 10),
            Text(
              'ReadyKuliah',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.school_outlined, size: 25),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Siap Berangkat?',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF29284F),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Pastikan semua perlengkapan kuliahmu sudah siap.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // CUSTOM WIDGET RINGKASAN
                  KartuRingkasan(
                    jumlahSiap: jumlahSiap,
                    jumlahBarang: daftarBarang.length,
                    jumlahWajibSiap: jumlahWajibSiap,
                    jumlahWajib: jumlahWajib,
                    persentase: persentaseKesiapan,
                  ),

                  const SizedBox(height: 24),

                  // JUDUL DAFTAR
                  const Row(
                    children: [
                      Icon(
                        Icons.checklist_rounded,
                        color: Color(0xFF5856A6),
                        size: 25,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Daftar Perlengkapan',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // DAFTAR BARANG
                  ...daftarBarang.map(
                    (barang) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: KartuPerlengkapan(
                        barang: barang,
                        onPressed: () {
                          setState(() {
                            barang.sudahSiap = !barang.sudahSiap;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // PESAN STATUS
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: jumlahWajibSiap == jumlahWajib
                          ? const Color(0xFFE2F4E8)
                          : const Color(0xFFFFF2D5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          jumlahWajibSiap == jumlahWajib
                              ? Icons.verified_rounded
                              : Icons.notifications_active_outlined,
                          color: jumlahWajibSiap == jumlahWajib
                              ? const Color(0xFF267547)
                              : const Color(0xFF956500),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            jumlahWajibSiap == jumlahWajib
                                ? 'Semua barang wajib sudah siap. Kamu bisa berangkat!'
                                : 'Masih ada ${jumlahWajib - jumlahWajibSiap} barang wajib yang perlu disiapkan.',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // TOMBOL RESET
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: jumlahSiap == 0
                          ? null
                          : () {
                              setState(() {
                                for (final barang in daftarBarang) {
                                  barang.sudahSiap = false;
                                }
                              });
                            },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset Semua Checklist'),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'ReadyKuliah • Persiapan lebih teratur',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// CUSTOM WIDGET KARTU RINGKASAN
class KartuRingkasan extends StatelessWidget {
  final int jumlahSiap;
  final int jumlahBarang;
  final int jumlahWajibSiap;
  final int jumlahWajib;
  final double persentase;

  const KartuRingkasan({
    super.key,
    required this.jumlahSiap,
    required this.jumlahBarang,
    required this.jumlahWajibSiap,
    required this.jumlahWajib,
    required this.persentase,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF5856A6),
            Color(0xFF8583CF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5856A6).withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Persiapan Hari Ini',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.auto_awesome,
                color: Color(0xFFFFD66B),
                size: 28,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              KotakStatistik(
                angka: '$jumlahSiap/$jumlahBarang',
                label: 'Barang siap',
                ikon: Icons.check_circle_outline,
              ),
              KotakStatistik(
                angka: '$jumlahWajibSiap/$jumlahWajib',
                label: 'Barang wajib',
                ikon: Icons.assignment_turned_in_outlined,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Progres persiapan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text(
                '${(persentase * 100).round()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: persentase,
              minHeight: 9,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFFFD66B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CUSTOM WIDGET STATISTIK
class KotakStatistik extends StatelessWidget {
  final String angka;
  final String label;
  final IconData ikon;

  const KotakStatistik({
    super.key,
    required this.angka,
    required this.label,
    required this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ikon, color: const Color(0xFFFFD66B), size: 23),
          const SizedBox(height: 8),
          Text(
            angka,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// CUSTOM WIDGET KARTU PERLENGKAPAN
class KartuPerlengkapan extends StatelessWidget {
  final Perlengkapan barang;
  final VoidCallback onPressed;

  const KartuPerlengkapan({
    super.key,
    required this.barang,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: barang.sudahSiap
          ? const Color(0xFFE9F4ED)
          : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: barang.sudahSiap
              ? const Color(0xFFB9DCC4)
              : const Color(0xFFE6E5F0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: barang.sudahSiap
                        ? const Color(0xFFD0EBD8)
                        : const Color(0xFFEAE9FA),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    barang.ikon,
                    color: barang.sudahSiap
                        ? const Color(0xFF267547)
                        : const Color(0xFF5856A6),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        barang.nama,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration: barang.sudahSiap
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        barang.kategori,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          LabelKecil(
                            teks: 'Jumlah: ${barang.jumlah}',
                            warna: const Color(0xFFEAE9FA),
                          ),
                          LabelKecil(
                            teks: barang.wajib ? 'Wajib' : 'Opsional',
                            warna: barang.wajib
                                ? const Color(0xFFFFF0C2)
                                : const Color(0xFFE8E8EC),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(
                  barang.sudahSiap
                      ? Icons.undo
                      : Icons.check_circle_outline,
                  size: 18,
                ),
                label: Text(
                  barang.sudahSiap ? 'Batalkan' : 'Tandai Siap',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// LABEL KATEGORI KECIL
class LabelKecil extends StatelessWidget {
  final String teks;
  final Color warna;

  const LabelKecil({
    super.key,
    required this.teks,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        teks,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
