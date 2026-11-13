# Tugas Rutin 2: Kasir Console
Nama: Zahira Putri Julia Daulay | NIM: 4243550008

## Cara menjalankan
dart run bin/kasir.dart

## Skenario 1: pesanan valid + diskon
Input: P01x2, P05x1, P09x3
Hasil: P01x2, P05x1, P09x3

Pesanan: P01x2, P05x1, P09x3

Kopi Sidikalang 250 g   2 x    90000
Bolu Meranti            1 x    80000
Total                         170000
Diskon 10%                     17000
Bayar                         153000

Kategori dibeli: Minuman, Makanan
Diabaikan: P09x3

## Skenario 2: input salah
Input: P02x1, P03x2, P99x1, abc, P04xdua
Hasil: P02x1, P03x2, P99x1, abc, P04xdua

Pesanan: P02x1, P03x2, P99x1, abc, P04xdua

Teh Tarik Instan        1 x    25000
Keripik Singkong        2 x    36000
Total                          61000
Bayar                          61000

Kategori dibeli: Minuman, Makanan
Diabaikan: P99x1, abc, P04xdua

## Penjelasan var / final / const
- `const batasDiskon = 100000` : nilainya sudah pasti sejak kode ditulis (saat kompilasi).
- `final katalog`, `final input`, `final total` : diisi sekali saat program berjalan, lalu tidak diganti.
- `var` : tidak saya pakai karena tidak ada nilai yang perlu diubah-ubah.

## Penjelasan null safety
- `int.tryParse` dan `katalog[kode]` bisa menghasilkan `null` (int? dan Produk?).
- Saya cek `if (produk == null || jumlah == null ...)` sebelum memakainya, jadi kode salah tidak membuat program crash.
- Operator `??` dipakai pada `stdin.readLineSync() ?? ''` agar input kosong menjadi teks kosong.
- Saya tidak memakai tanda `!` karena pengecekan `if` sudah cukup aman.