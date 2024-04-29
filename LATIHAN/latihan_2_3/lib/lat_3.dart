import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/* 
{"data":[{"name": "Akademi Farmasi Mitra Sehat Mandiri Sidoarjo", "state-province": null, "domains": ["akfarmitseda.ac.id"], "web_pages": ["http://www.akfarmitseda.ac.id/"], "alpha_two_code": "ID", "country": "Indonesia"}, 
{"name": "Institut Sains & Teknologi Akprind", "state-province": null, "domains": ["akprind.ac.id"], "web_pages": ["http://www.akprind.ac.id/"], "alpha_two_code": "ID", "country": "Indonesia"}, 
{"name": "STMIK AMIKOM Yogyakarta", "state-province": null, "domains": ["amikom.ac.id"], "web_pages": ["http://www.amikom.ac.id/"], "alpha_two_code": "ID", "country": "Indonesia"}, 
{"name": "STIKES RS Anwar Medika", "state-province": null, "domains": ["stikesrsanwarmedika.ac.id"], "web_pages": ["http://www.stikesrsanwarmedika.ac.id/"], "alpha_two_code": "ID", "country": "Indonesia"}, 
{"name": "Universitas Katolik Indonesia Atma Jaya", "state-province": null, "domains": ["atmajaya.ac.id"], "web_pages": ["http://www.atmajaya.ac.id/"], "alpha_two_code": "ID", "country": "Indonesia"},
 …. 
{"name": "Duta Bangsa University", "state-province": null, "domains": ["udb.ac.id"], "web_pages": ["https://udb.ac.id/"], "alpha_two_code": "ID", "country": "Indonesia"}, 
{"name": "Akademi Farmasi Yarsis Pekanbaru", "state-province": null, "domains": ["akfaryarsiptk.ac.id"], "web_pages": ["https://akfaryarsiptk.ac.id"], "alpha_two_code": "ID", "country": "Indonesia"}]
  

*/

// Mendefinisikan kelas University dengan dua properti: name dan website
class University {
  String name; //menyimpan nama universitas
  String website; //menyimpan website universitas

  University({required this.name, required this.website});
}

// Mendefinisikan kelas UniversityList untuk mengelola daftar universitas
class UniversityList {
  List<University> ListPop = <University>[]; // Daftar objek University
  UniversityList(List<dynamic> json) {
    for (var val in json) {
      var name = val["name"];
      var website = val["web_pages"][0];

      ListPop.add(University(name: name, website: website));
    }
  }

  factory UniversityList.fromJson(List<dynamic> json) {
    return UniversityList(json);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  late Future<UniversityList>
      futureUniversityList; // Variabel untuk menyimpan data universitas yang akan diambil nanti

  String url = "http://universities.hipolabs.com/search?country=Indonesia";

  // Fungsi untuk mengambil data universitas dari API
  Future<UniversityList> fetchData() async {
    final response =
        await http.get(Uri.parse(url)); // Kirim permintaan GET ke URL API

    if (response.statusCode == 200) {
      // Periksa apakah respon berhasil (kode status 200)
      List<dynamic> data =
          jsonDecode(response.body); // Urai data JSON dari respon
      return UniversityList.fromJson(
          data); // Konversi data JSON menjadi objek UniversityList
    } else {
      throw Exception(
          'Gagal load'); // Lemparkan exception jika gagal mengambil data
    }
  }

  @override
  void initState() {
    super.initState();
    futureUniversityList =
        fetchData(); // Panggil fungsi fetchData saat aplikasi dimulai untuk mengambil data universitas
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Universitas di Indonesia',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Universitas di Indonesia'), //judul appbar
          ),
          body: Center(
            child: FutureBuilder<UniversityList>(
              future:
                  futureUniversityList, // Gunakan data yang akan diambil dari fungsi fetchData
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    //gunakan listview builder
                    child: ListView.builder(
                      itemCount: snapshot
                          .data!.ListPop.length, //asumsikan data ada isi
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(border: Border.all()),
                            padding: const EdgeInsets.all(14),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(snapshot.data!.ListPop[index]
                                      .name //tampilkan nama universitas
                                      .toString()),
                                  Text(snapshot.data!.ListPop[index]
                                      .website //tampilkan url website
                                      .toString()),
                                ]));
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                      '${snapshot.error}'); //Tampilkan pesan kesalahan jika terjadi error saat mengambil data
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ));
  }
}
