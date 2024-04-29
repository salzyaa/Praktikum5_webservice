import 'dart:convert';

void main() {
  String nama = "Ahmad Aulia";
  int umur = 20;
  List<dynamic> listBahasa = ["php", "js"];
  String mhs2json = jsonEncode({"nama": nama, "umur": umur, "list_bahasa": listBahasa});
  print(mhs2json);
}
