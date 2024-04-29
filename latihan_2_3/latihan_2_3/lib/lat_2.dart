import 'package:flutter/material.dart'; // Import library untuk menggunakan Flutter UI framework
import 'package:http/http.dart' as http; // Import library http untuk melakukan HTTP requests
import 'dart:convert'; // Import library dart:convert untuk melakukan parsing JSON

void main() {
  runApp(const MyApp()); // Fungsi main, di dalamnya dijalankan MyApp sebagai aplikasi utama
}

// menampung data hasil pemanggilan API
class Activity { // Deklarasi class Activity untuk merepresentasikan data aktivitas
  String aktivitas; // Deklarasi variabel aktivitas bertipe String
  String jenis; // Deklarasi variabel jenis bertipe String

  Activity({required this.aktivitas, required this.jenis}); // Constructor dengan parameter wajib aktivitas dan jenis

  //map dari json ke atribut
  factory Activity.fromJson(Map<String, dynamic> json) { // Factory method untuk membuat instance Activity dari JSON
    return Activity( // Mengembalikan instance Activity dengan atribut yang diambil dari JSON
      aktivitas: json['activity'], // Mengambil nilai aktivitas dari JSON
      jenis: json['type'], // Mengambil nilai jenis dari JSON
    );
  }
}

class MyApp extends StatefulWidget { // Deklarasi class MyApp yang merupakan StatefulWidget
  const MyApp({Key? key}) : super(key: key); // Constructor MyApp

  @override
  State<StatefulWidget> createState() { // Override method createState untuk membuat state baru
    return MyAppState(); // Mengembalikan instance dari MyAppState
  }
}

class MyAppState extends State<MyApp> {
  late Future<Activity> futureActivity; //menampung hasil

  //late Future<Activity>? futureActivity;
  String url = "https://www.boredapi.com/api/activity";

  Future<Activity> init() async {
    return Activity(aktivitas: "", jenis: "");
  }

  //fetch data
  Future<Activity> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // jika server mengembalikan 200 OK (berhasil),
      // parse json
      return Activity.fromJson(jsonDecode(response.body));
    } else {
      // jika gagal (bukan  200 OK),
      // lempar exception
      throw Exception('Gagal load');
    }
  }

  @override
void initState() { // Ini adalah metode yang dipanggil pertama kali saat widget diinisialisasi.
  super.initState(); // Memanggil metode initState dari kelas induk (StatefulWidget).
  futureActivity = init(); // Menginisialisasi futureActivity dengan hasil dari metode init.
}

  @override
Widget build(Object context) { // Metode build yang akan membangun tampilan widget.
  return MaterialApp( // Menggunakan MaterialApp sebagai root widget aplikasi.
      home: Scaffold( // Scaffold adalah kelas untuk mengatur struktur dasar sebuah aplikasi.
    body: Center( // Mengatur konten ke tengah layar.
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [ // Menggunakan kolom untuk menata elemen secara vertikal di tengah layar.
        Padding( // Memberikan padding di sekitar tombol.
          padding: EdgeInsets.only(bottom: 20), // Memberikan jarak ke bawah.
          child: ElevatedButton( // Tombol dengan tampilan yang lebih menonjol.
            onPressed: () { // Ketika tombol ditekan.
              setState(() { // Mengubah state widget.
                futureActivity = fetchData(); // Memuat data baru saat tombol ditekan.
              });
            },
            child: Text("Saya bosan ..."), // Teks yang ditampilkan di dalam tombol.
          ),
        ),
          FutureBuilder<Activity>( // Membuat widget FutureBuilder untuk membangun UI berdasarkan status Future yang diberikan.
            future: futureActivity, // Menggunakan properti future untuk memberikan futureActivity sebagai sumber data.
            builder: (context, snapshot) { // Menggunakan properti builder untuk membangun UI berdasarkan status snapshot dari future.
              if (snapshot.hasData) { // Memeriksa apakah snapshot memiliki data yang telah diambil.
                return Center( // Jika snapshot memiliki data, maka tampilkan data di dalam widget Center dan Column.
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(snapshot.data!.aktivitas), // Menampilkan teks dari atribut aktivitas data snapshot.
                      Text("Jenis: ${snapshot.data!.jenis}") // Menampilkan teks yang menyertakan jenis dari data snapshot.
                    ]));
              } else if (snapshot.hasError) { // Jika snapshot memiliki error, tampilkan teks error.
                return Text('${snapshot.error}');
              }
              // default: loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ]),
      ),
    ));
  }
}