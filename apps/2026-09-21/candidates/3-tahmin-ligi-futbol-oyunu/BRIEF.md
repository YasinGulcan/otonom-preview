# Tahmin Ligi – Sosyal Süper Lig Tahmin Oyunu

- **Kategori**: oyun
- **Slug**: tahmin-ligi-futbol-oyunu
- **Kaynak stratejisi**: (a) yerel pazar boşluğu (destekleyici sinyal: (b) genel küresel trend)

## Neden bugün fırsat / neden yükselişte
Türkiye Apple "Top Free" listesinde (`rss.marketingtools.apple.com/api/v2/tr/apps/top-free/25/apps.json`,
21 Eylül 2026 anlık verisi) **Mackolik Live Score | M Scores** #4 sırada — futbol skor/takip
ilgisinin Türkiye'de ne kadar güçlü ve günlük olduğunu gösteren doğrudan yerel sinyal (ayrıca
aynı listede beIN CONNECT #5 ve TOD: Spor, Dizi & Film İzle #22 de spor içerik tüketimini
destekliyor). Buna karşın TR top 25'te ücretsiz, sosyal, reklam+IAP destekli, **gerçek para
içermeyen** bir "maç tahmin/lig oyunu" yok. Aynı zamanda ABD Apple "Top Free" listesinde
(`.../us/apps/top-free/25/apps.json`, aynı tarih) **Kalshi: Trade Football & more** #4 ve
**Polymarket: Trade Live Sports** #5 sırada — "tahmin etme" mekaniğinin (prediction market)
küresel ölçekte ne kadar güçlü bir katılım motoru olduğunu gösteriyor. Bu konsept, o tahmin
mekaniğinin katılım gücünü alıp gerçek para bahis/işlem unsurunu tamamen çıkararak (yalnızca
puan/lig sıralaması), Türkiye'nin en güçlü yerel tutkularından biri olan Süper Lig etrafında,
mağaza politikasına uygun, sosyal bir beceri oyununa dönüştürür.

## Gelir potansiyeli
Maç arası/sonrası ödüllü reklam (rewarded video ile "ekstra tahmin hakkı" veya "çifte puan"),
banner/interstitial reklam gelirinin yanı sıra kozmetik IAP (özel rozet, avatar çerçevesi,
özel lig adı/logo oluşturma) ve haftalık "VIP Lig" (reklamsız + bonus istatistik) aboneliği.
Gerçek para bahis olmadığı için reklam ağı onayı ve mağaza incelemesi düz bir oyun uygulaması
gibi ilerler; gelir esas olarak yüksek günlük açılma sıklığı (her maç haftası tekrar kullanım)
üzerinden reklam gösterim hacmiyle ölçeklenir.

## Çekirdek mekanik / değer önerisi
Kullanıcı her hafta Süper Lig maçları için skor tahmini yapar (ör. 2-1), doğru sonuç/doğru skor
için puan kazanır, arkadaşlarıyla veya genel kullanıcı tabanıyla haftalık/sezonluk liderlik
tablosunda yarışır. Arkadaşlarla özel "mini lig" kurma (davet kodu ile) sosyal bağlılığı ve
geri dönüşü artıran çekirdek döngüdür.

## MVP özellik listesi
- Haftalık Süper Lig fikstürü listesi (statik/manuel güncellenen veri ile MVP, ileride canlı API)
- Skor tahmin girişi ekranı (maç başlamadan önce kilitlenir)
- Puanlama motoru (doğru sonuç / doğru skor için farklı puan)
- Genel liderlik tablosu (haftalık + sezonluk)
- Arkadaşlarla davet kodlu "mini lig" oluşturma
- Rewarded video ile ekstra tahmin hakkı
- TR/EN dil desteği

## MVP dışı bırakılanlar
- Gerçek para bahis/ödül çekme mekanizması (kesinlikle kapsam dışı — politika riski)
- Canlı maç API entegrasyonu / otomatik skor güncelleme (MVP'de manuel/simüle veri)
- Çoklu lig (yalnızca Süper Lig ile başla; Şampiyonlar Ligi vb. faz 2)
- Uygulama içi sohbet/mesajlaşma
- Gelişmiş istatistik/analiz paneli

## Checklist sonucu
- Yerel uygunluk: Çok yüksek — Türkiye'de futbol/Süper Lig ilgisi ve Mackolik'in TR top 25'teki
  #4 konumu doğrudan kanıt.
- Dil/yerelleştirme: Kolay — arayüz ve takım/maç verisi TR odaklı başlar, EN ikincil dil olarak
  eklenebilir.
- Mağaza politikası riski: **Önemli uyarı** — gerçek para bahis/kumar ile karıştırılmaması için
  uygulama açıkça "gerçek para ödülü/çekimi yoktur, yalnızca eğlence/puan" ifadesini içermeli;
  Apple/Google'ın kumar kategorisi incelemesine takılmamak için ödeme/bahis dili tamamen
  kaçınılmalı, yalnızca "tahmin oyunu" çerçevesi korunmalı.
- Çocuk içeriği: yok — genel kitle, yaş kısıtı gerekmez (gerçek para unsuru olmadığı için).
- Teknik fizibilite: Yüksek — Flutter'da form/liste/liderlik tablosu UI + basit puanlama mantığı
  tek oturumda gerçekçi şekilde MVP olarak kurulabilir; MVP'de canlı veri yerine manuel/statik
  fikstür kullanılarak gerçek zamanlı altyapı ihtiyacı MVP kapsamından çıkarılmıştır.

## Özgünlük Beyanı
Bu konsept, tahmin/prediction-market katılım mekaniğinden ve Türkiye'nin yerel futbol takip
kültüründen ilham almıştır; hiçbir isim, marka, logo veya görsel belirli bir rakip uygulamadan
(Mackolik, Kalshi, Polymarket vb.) kopyalanmamıştır ve gerçek para bahis unsuru içermez.
