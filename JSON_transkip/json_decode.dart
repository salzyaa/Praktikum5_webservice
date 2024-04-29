import 'dart:convert';

void main() {
  // JSON transkrip mahasiswa
  String transkripJson = '''
  {
    "nama": "Budi Martami",
    "nim": "123456789",
    "jurusan": "Sistem Informasi",
    "semester": 4,
    "mata_kuliah": [
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
        "nilai": "B+"
      },
      {
        "kode": "SI301",
        "matkul": "MPSI",
        "sks": 3,
        "nilai": "A-"
      }
    ]
  }
  ''';

  // Decode JSON transkrip mahasiswa
  Map<String, dynamic> transkrip = jsonDecode(transkripJson);

  // Mendapatkan informasi dari JSON
  String nama = transkrip['nama']; // Mendapatkan nama mahasiswa dari JSON
  String nim = transkrip['nim']; // Mendapatkan NIM mahasiswa dari JSON
  List<dynamic> mataKuliah = transkrip['mata_kuliah']; // Mendapatkan data mata kuliah dari JSON

  // Menampilkan informasi mahasiswa
  print('Nama: $nama'); // Mencetak nama mahasiswa
  print('NIM: $nim'); // Mencetak NIM mahasiswa
  print('--------------------------');

  // Menampilkan informasi mata kuliah
  for (var matkul in mataKuliah) {
    print('Kode: ${matkul['kode']}'); // Mencetak kode mata kuliah
    print('Mata Kuliah: ${matkul['matkul']}'); // Mencetak nama mata kuliah
    print('SKS: ${matkul['sks']}'); // Mencetak jumlah SKS mata kuliah
    print('Nilai: ${matkul['nilai']}'); // Mencetak nilai mata kuliah
    print('--------------------------');
  }

  // Hitung dan mencetak total SKS
  double totalSKS = calculateTotalSKS(mataKuliah);
  print('Total SKS: $totalSKS');

  // Hitung dan mencetak IPK
  double ipk = calculateIPK(mataKuliah);
  print('IPK: $ipk');
}

// Hitung dan mencetak total SKS
double calculateTotalSKS(List<dynamic> mataKuliah) {
  double totalSKS = 0;
  for (var matkul in mataKuliah) {
    totalSKS += matkul['sks']; // Menambahkan jumlah SKS dari setiap mata kuliah
  }
  return totalSKS;
}

// Hitung dan mencetak IPK
double calculateIPK(List<dynamic> mataKuliah) {
  double totalBobot = 0; // Total bobot nilai
  int totalSKS = 0; // Total SKS

  for (var matkul in mataKuliah) {
    int sks = matkul['sks']; // Jumlah SKS dari mata kuliah
    totalSKS += sks; // Menambahkan jumlah SKS total
    totalBobot += sks * getBobotNilai(matkul['nilai']); // Menambahkan bobot nilai dari mata kuliah
  }

  return totalBobot / totalSKS; // Menghitung IPK
}

// Mendapatkan bobot nilai
double getBobotNilai(String nilai) {
  switch (nilai) {
    case 'A':
      return 4.0;
    case 'A-':
      return 3.7;
    case 'B+':
      return 3.3;
    // Tambahkan penanganan nilai lain jika diperlukan
    default:
      return 0.0; // Nilai tidak valid, tidak memberikan bobot
  }
}


