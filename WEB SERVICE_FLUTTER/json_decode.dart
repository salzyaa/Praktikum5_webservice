import 'dart:convert';

void main() {
  String jsonString =
      '{"nama": "Budi Martami", "umur":17, "list_bahasa": ["C++", "Python"]}';
  Map<String, dynamic> mhsJson = jsonDecode(jsonString); //json ke Map
  print("nama: ${mhsJson['nama']}");
  print("umur: ${mhsJson['umur']}");
  print("skill: ${mhsJson['list_bahasa']}");
  //cetak satu-satu
  for (String val in mhsJson['list_bahasa']) {
    print(val);
  }
}

