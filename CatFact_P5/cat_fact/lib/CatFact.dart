// sebaiknya di class terpisah
// menapung data hasil pemanggilan API
class CatFact {

  String fakta;
  int panjang;

  CatFact({required this.fakta, required this.panjang});

  //map dari json ke atribut
  factory CatFact.fromJson(Map<String, dynamic> json) {
    return CatFact(
      fakta: json['fact'],
      panjang: json['length'],
    );
  }
}
