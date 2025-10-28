//kelas abstrak sebagai induk dari semua transportasi
abstract class Transportasi {
  String id, nama;
  double _tarif;
  int kapasitas;

  Transportasi(this.id, this.nama, this._tarif, this.kapasitas);

  //getter untuk tarif (enkapsulasi)
  double get tarif => _tarif;

  //method ebstrak (harus di override di kelas turunan)
  double hitung(int jml);
}

//kelas turunan (inheritans + polomorfisme)
//taksi : tarif = tarifdasar * jarak

class Taksi extends Transportasi {
  double jarak;
  Taksi(super.id, super.nama, super._tarif, super.kapasitas, this.jarak);

  @override
  double hitung(int jml) => tarif * jarak;
}

//Bus: tarif = (tarifdasar * jmlpenumpang) * (wifi ? 5000 :0)

class Bus extends Transportasi {
  bool wifi;
  Bus(super.id, super.nama, super._tarif, super.kapasitas, this.wifi);

  @override
  double hitung(int jml) => (tarif * jml) + (wifi ? 5000 : 0);
}

//kelas pesawat: tarif = tarifdasar * jmlpenumpang * faktor kelas

class Pesawat extends Transportasi {
  String kelas;
  Pesawat(super.id, super.nama, super._tarif, super.kapasitas, this.kelas);

  @override
  double hitung(int jml) => tarif * jml * (kelas == "Bisnis" ? 1.5 : 1.0);
}

//kelas pemesanan
class Pemesanan {
  String id, nama;
  Transportasi t;
  int jml;
  double total;
  Pemesanan(this.id, this.nama, this.t, this.jml, this.total);

  //menampilkan struktur pemesanan
  void struk() => print("$id - $nama | ${t.nama} | $jml org | Rp$total");
}
//fungsi global
//untuk membuat objek pemesanan baru

Pemesanan pesan(Transportasi t, String nama, int jml, String id) =>
    Pemesanan(id, nama, t, jml, t.hitung(jml));

//membuat semua daftar pemesanan
void tampil(List<Pemesanan> list) {
  print("\n=== DAFTAR PEMESANAN ===");
  for (var p in list) {
    p.struk();
  }
}
//fungsi main (program utama)

void main() {
  //membuat beberapa ebjak tranportasi
  var taksi = Taksi("T01", "Blue Bird", 8500, 3, 10);
  var bus = Bus("B01", "TransJakarta", 4000, 20, true);
  var pesawat = Pesawat("P01", "Garuda", 1300000, 140, "Bisnis");

  //membuat daftar pemesanan menggunakan fungsi global
  var daftar = [
    pesan(taksi, "indri", 3, "PM01"), //pemesanan 1
    pesan(bus, "yuli", 2, "PM02"), //pemesanan 2
    pesan(taksi, "nurul", 1, "PM03"), //pemesanan 3
  ];
  //menampilkan semua pemesanan
  tampil(daftar);
}
