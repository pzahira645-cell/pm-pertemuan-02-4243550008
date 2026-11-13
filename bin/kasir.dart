import 'dart:io';

// Produk = satu baris data barang (nama, harga, kategori)
typedef Produk = ({String nama, int harga, String kategori});

// const: nilainya sudah pasti dari awal, tidak pernah berubah
const int batasDiskon = 100000;

// KATALOG: Map dari kode -> Produk (isi minimal 5)
final Map<String, Produk> katalog = {
  'P01': (nama: 'Kopi Sidikalang 250 g', harga: 45000, kategori: 'Minuman'),
  'P02': (nama: 'Teh Tarik Instan', harga: 25000, kategori: 'Minuman'),
  'P03': (nama: 'Keripik Singkong', harga: 18000, kategori: 'Makanan'),
  'P04': (nama: 'Sirup Markisa', harga: 30000, kategori: 'Minuman'),
  'P05': (nama: 'Bolu Meranti', harga: 80000, kategori: 'Makanan'),
  'P06': (nama: 'Kain Ulos Mini', harga: 120000, kategori: 'Kerajinan'),
};

void tampilkanKatalog() {
  print('===== KATALOG =====');
  katalog.forEach((kode, p) {
    print(
      '${kode.padRight(5)}'
      '${p.nama.padRight(24)}'
      '${p.harga.toString().padLeft(8)}  '
      '${p.kategori}',
    );
  });
}

void main() {
  tampilkanKatalog();

  stdout.write('\nPesanan (contoh: P01x2, P05x1): ');
  final input = stdin.readLineSync() ?? '';

  // Dua keranjang: yang benar dan yang salah
  final valid = <({Produk produk, int jumlah})>[];
  final diabaikan = <String>[];

  // PESANAN: pecah per koma, lalu pecah per 'x'
  for (final bagian in input.split(',')) {
    final teks = bagian.trim();
    if (teks.isEmpty) continue;

    final pecah = teks.toUpperCase().split('X');
    if (pecah.length != 2) {
      diabaikan.add(teks);
      continue;
    }

    final kode = pecah[0].trim();
    final jumlah = int.tryParse(pecah[1].trim()); // int? (bisa null)
    final produk = katalog[kode]; // Produk? (bisa null)

    // NULL SAFETY: kalau salah satu null, jangan lanjut
    if (produk == null || jumlah == null || jumlah <= 0) {
      diabaikan.add(teks);
      continue;
    }

    valid.add((produk: produk, jumlah: jumlah));
  }

  if (valid.isEmpty) {
    print('\nTidak ada pesanan yang valid.');
    if (diabaikan.isNotEmpty) print('Diabaikan: ${diabaikan.join(', ')}');
    return;
  }

  // STRUK
  print('\nPesanan: $input\n');
  for (final p in valid) {
    final subtotal = p.produk.harga * p.jumlah;
    print(
      '${p.produk.nama.padRight(24)}'
      '${p.jumlah} x ${subtotal.toString().padLeft(8)}',
    );
  }

  final total = valid
      .map((p) => p.produk.harga * p.jumlah)
      .fold<int>(0, (s, n) => s + n);

  final diskon = total >= batasDiskon ? total ~/ 10 : 0;
  final bayar = total - diskon;
  final kategori = valid.map((p) => p.produk.kategori).toSet();

  print('${'Total'.padRight(24)}${total.toString().padLeft(12)}');
  if (diskon > 0) {
    print('${'Diskon 10%'.padRight(24)}${diskon.toString().padLeft(12)}');
  }
  print('${'Bayar'.padRight(24)}${bayar.toString().padLeft(12)}');
  print('\nKategori dibeli: ${kategori.join(', ')}');

  if (diabaikan.isNotEmpty) {
    print('Diabaikan: ${diabaikan.join(', ')}');
  }
}
