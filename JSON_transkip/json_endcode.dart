import 'dart:convert';

void main() {
  // Informasi mahasiswa
  String nama = "Anggi Martami"; // Menyimpan nama mahasiswa
  String nim = "123456789"; // Menyimpan NIM mahasiswa
  String jurusan = "Sistem Informasi"; // Menyimpan jurusan mahasiswa
  int semester = 4; // Menyimpan semester mahasiswa

  // Data mata kuliah
  List<Map<String, dynamic>> mataKuliah = [ // Mendefinisikan daftar mata kuliah menggunakan List<Map>
    {
      "kode": "SI101", 
      "matkul": "Pemrograman Mobile", 
      "sks": 3, 
      "nilai": "A" 
    },
    {
      "kode": "SI201",
      "matkul": "Pemrograman Web",
      "sks": 3,
      "nilai": "A"
    },
    {
      "kode": "SI301",
      "matkul": "MPSI",
      "sks": 3,
      "nilai": "A-"
    }
  ];

  // Buat objek untuk transkrip mahasiswa
  Map<String, dynamic> transkrip = { // Mendefinisikan objek transkrip menggunakan Map
    "nama": nama, // Menyimpan nama mahasiswa dalam transkrip
    "nim": nim, // Menyimpan NIM mahasiswa dalam transkrip
    "jurusan": jurusan, // Menyimpan jurusan mahasiswa dalam transkrip
    "semester": semester, // Menyimpan semester mahasiswa dalam transkrip
    "mata_kuliah": mataKuliah, // Menyimpan daftar mata kuliah dalam transkrip
  };

  // Encode ke JSON
  String transkripJson = jsonEncode(transkrip); // Mengubah objek transkrip menjadi JSON

  // Tampilkan JSON
  print(transkripJson); // Menampilkan JSON dari objek transkrip

  // Tampilkan informasi dengan format yang diinginkan
  print('nama: $nama'); // Menampilkan nama mahasiswa
  print('nim: $nim'); // Menampilkan NIM mahasiswa
  print('------------------');
  for (var matkul in mataKuliah) { // Iterasi melalui daftar mata kuliah
    print('kode: ${matkul['kode']}'); // Menampilkan kode mata kuliah
    print('mata kuliah: ${matkul['matkul']}'); // Menampilkan nama mata kuliah
    print('sks: ${matkul['sks']}'); // Menampilkan jumlah SKS mata kuliah
    print('nilai: ${matkul['nilai']}'); // Menampilkan nilai mata kuliah
    print('------------------');
  }
  print('total sks: ${calculateTotalSKS(mataKuliah)}'); // Menampilkan total SKS
  print('total ipk: ${calculateIPK(mataKuliah)}'); // Menampilkan IPK
}


// Hitung dan mencetak total SKS
double calculateTotalSKS(List<dynamic> mataKuliah) {
  double totalSKS = 0; // Menyimpan total SKS

  for (var matkul in mataKuliah) { // Iterasi melalui daftar mata kuliah
    totalSKS += matkul['sks']; // Menambahkan jumlah SKS dari setiap mata kuliah
  }
  return totalSKS; // Mengembalikan total SKS
}

// Hitung dan mencetak IPK
double calculateIPK(List<Map<String, dynamic>> mataKuliah) {
  double totalBobot = 0; // Menyimpan total bobot nilai
  double totalSKS = 0; // Menyimpan total SKS

  for (var matkul in mataKuliah) { // Iterasi melalui daftar mata kuliah
    double sks = matkul['sks'].toDouble(); // Mengkonversi jumlah SKS menjadi tipe data double
    totalSKS += sks; // Menambahkan jumlah SKS
    totalBobot += sks * getBobotNilai(matkul['nilai']); // Menambahkan bobot nilai untuk perhitungan IPK
  }

  return totalBobot / totalSKS; // Mengembalikan IPK
}

// Fungsi untuk mendapatkan bobot nilai
double getBobotNilai(String nilai) {
  switch (nilai) { // Memeriksa nilai mata kuliah
    case 'A':
      return 4.0; // Mengembalikan bobot nilai untuk nilai 'A'
    case 'A-':
      return 3.7; // Mengembalikan bobot nilai untuk nilai 'A-'
    case 'B+':
      return 3.3; // Mengembalikan bobot nilai untuk nilai 'B+'
    case 'B':
      return 3.0; // Mengembalikan bobot nilai untuk nilai 'B'
    case 'B-':
      return 2.7; // Mengembalikan bobot nilai untuk nilai 'B-'
    // Tambahkan penanganan untuk nilai lain jika diperlukan
    default:
      return 0.0; // Nilai tidak valid, tidak memberikan bobot
  }
}
