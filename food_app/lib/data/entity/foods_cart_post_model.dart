class FoodCartPostModel {
  String? yemekAdi;
  String? yemekResimAdi;
  int? yemekFiyat;
  int? yemekSiparisAdet;
  String? kullaniciAdi;

  FoodCartPostModel(
      {this.yemekAdi,
      this.yemekResimAdi,
      this.yemekFiyat,
      this.yemekSiparisAdet,
      this.kullaniciAdi});

  FoodCartPostModel.fromJson(Map<String, dynamic> json) {
    yemekAdi = json['yemek_adi'];
    yemekResimAdi = json['yemek_resim_adi'];
    yemekFiyat = json['yemek_fiyat'];
    yemekSiparisAdet = json['yemek_siparis_adet'];
    kullaniciAdi = json['kullanici_adi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['yemek_adi'] = yemekAdi;
    data['yemek_resim_adi'] = yemekResimAdi;
    data['yemek_fiyat'] = yemekFiyat;
    data['yemek_siparis_adet'] = yemekSiparisAdet;
    data['kullanici_adi'] = kullaniciAdi;
    return data;
  }
}
