/// Kilometre Mil Dönüşümü
double kilometreToMil(double kilometre) {
  return kilometre * 0.621;
}

/// Dikdörtgen Alanı Hesaplama
void dikdortgenAlaniHesaplama(double kenar1, double kenar2) {
  double alan = kenar1 * kenar2;
  print('Dikdörtgen alanı: $alan');
}

/// Faktöriyel Hesaplama
int faktoriyelHesaplama(int sayi) {
  if (sayi == 0) {
    return 1;
  } else {
    return sayi * faktoriyelHesaplama(sayi - 1);
  }
}

/// Kaç Adet e Harfi Var
void eHarfi(String kelime) {
  kelime = kelime.toLowerCase();
  int sayac = 0;
  for (int i = 0; i < kelime.length; i++) {
    if (kelime[i] == 'e') {
      sayac++;
    }
  }
  print('$sayac adet "e" harfi var.');
}

/// Kilometre Mil Dönüşümü
double icAciHesaplama(int kenarSayisi) {
  if (kenarSayisi < 3) {
    print("Geçersiz kenar sayısı. En az 3 kenar olmalıdır.");
    return 0;
  } else {
    double toplam = (kenarSayisi - 2) * 180;
    return (toplam / kenarSayisi);
  }
}

/// Maaş Hesaplama
double maasHesaplama(int calisilanGun) {
  double toplamMaas = 0.0;
  int toplamMesaiSaati = 150;

  int gunlukCalismaSaati = 8;
  double saatlikUcret = 40.0;
  double mesaiUcreti = 80.0;

  if (calisilanGun < 0) {
    print("Geçersiz gün sayısı. Gün sayısı negatif olamaz.");
  } else {
    int calisilanSaat = calisilanGun * gunlukCalismaSaati;
    int fazlaMesaiSaati = 0;

    if (calisilanSaat > toplamMesaiSaati) {
      fazlaMesaiSaati = calisilanSaat - toplamMesaiSaati;
      calisilanSaat = toplamMesaiSaati;
    }

    toplamMaas =
        (calisilanSaat * saatlikUcret) + (fazlaMesaiSaati * mesaiUcreti);
  }

  return toplamMaas;
}

/// Otopark Ücreti Hesaplama
int otoparkUcreti(int saat) {
  int saatUcreti = 50;
  int saatAsimiUcreti = 10;
  int toplamUcret = 0;

  if (saat < 1) {
    print("Geçersiz süre. Otopark süresi en az 1 saat olmalıdır.");
  } else {
    toplamUcret =
        (saat == 1 ? saatUcreti : saatUcreti + (saatAsimiUcreti * (saat - 1)));
  }

  return toplamUcret;
}

void main() {
  /// Değişkenler

  double kilometre = 10;

  double kenar1 = 5;
  double kenar2 = 3;

  int sayi = 5;

  String kelime = "Eren";

  int kenarSayisi = 4;

  int calisilanGun = 20;

  int otoparkSuresi = 3;

  /// Kilometre Mil Dönüşümü
  double mil = kilometreToMil(kilometre);
  print('Dönüşen Mil: $mil');

  /// Dikdörtgen Alanı Hesaplama
  dikdortgenAlaniHesaplama(kenar1, kenar2);

  /// Faktöriyel Hesaplama
  int faktoriyel = faktoriyelHesaplama(sayi);
  print('Faktoriyel: $faktoriyel');

  /// e Harfi Hesaplama
  eHarfi(kelime);

  /// Kenar İç Açı Hesaplama
  double icAciToplami = icAciHesaplama(kenarSayisi);
  print('Kenar Açısı $icAciToplami');

  /// Maas Hesaplama
  double maas = maasHesaplama(calisilanGun);
  print('Maaş:₺$maas');

  /// Otopark Ücreti
  int otoparkToplamUcret = otoparkUcreti(otoparkSuresi);
  print('Otopark Ücreti Toplamı:$otoparkToplamUcret');
}
