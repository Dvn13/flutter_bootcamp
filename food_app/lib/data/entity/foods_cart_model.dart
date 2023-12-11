class FoodCartModel {
  List<SepetYemekler>? sepetYemekler;
  int? success;

  FoodCartModel({this.sepetYemekler, this.success});

  FoodCartModel.fromJson(Map<String, dynamic> json) {
    if (json['sepet_yemekler'] != null) {
      sepetYemekler = <SepetYemekler>[];
      json['sepet_yemekler'].forEach((v) {
        sepetYemekler!.add( SepetYemekler.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sepetYemekler != null) {
      data['sepet_yemekler'] =
          sepetYemekler!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class SepetYemekler {
  String? sepetYemekId;
  String? yemekAdi;
  String? yemekResimAdi;
  String? yemekFiyat;
  String? yemekSiparisAdet;
  String? kullaniciAdi;

  SepetYemekler(
      {this.sepetYemekId,
      this.yemekAdi,
      this.yemekResimAdi,
      this.yemekFiyat,
      this.yemekSiparisAdet,
      this.kullaniciAdi});

  SepetYemekler.fromJson(Map<String, dynamic> json) {
    sepetYemekId = json['sepet_yemek_id'];
    yemekAdi = json['yemek_adi'];
    yemekResimAdi = json['yemek_resim_adi'];
    yemekFiyat = json['yemek_fiyat'];
    yemekSiparisAdet = json['yemek_siparis_adet'];
    kullaniciAdi = json['kullanici_adi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sepet_yemek_id'] = sepetYemekId;
    data['yemek_adi'] = yemekAdi;
    data['yemek_resim_adi'] = yemekResimAdi;
    data['yemek_fiyat'] = yemekFiyat;
    data['yemek_siparis_adet'] = yemekSiparisAdet;
    data['kullanici_adi'] = kullaniciAdi;
    return data;
  }
}