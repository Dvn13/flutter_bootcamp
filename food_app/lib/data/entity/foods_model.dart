class FoodsModel {
  List<Yemekler>? yemekler;
  int? success;

  FoodsModel({this.yemekler, this.success});

  FoodsModel.fromJson(Map<String, dynamic> json) {
    if (json['yemekler'] != null) {
      yemekler = <Yemekler>[];
      json['yemekler'].forEach((v) {
        yemekler!.add(Yemekler.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (yemekler != null) {
      data['yemekler'] = yemekler!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class Yemekler {
  String? yemekId;
  String? yemekAdi;
  String? yemekResimAdi;
  String? yemekFiyat;

  Yemekler({this.yemekId, this.yemekAdi, this.yemekResimAdi, this.yemekFiyat});

  Yemekler.fromJson(Map<String, dynamic> json) {
    yemekId = json['yemek_id'];
    yemekAdi = json['yemek_adi'];
    yemekResimAdi = json['yemek_resim_adi'];
    yemekFiyat = json['yemek_fiyat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['yemek_id'] = yemekId;
    data['yemek_adi'] = yemekAdi;
    data['yemek_resim_adi'] = yemekResimAdi;
    data['yemek_fiyat'] = yemekFiyat;
    return data;
  }
}
