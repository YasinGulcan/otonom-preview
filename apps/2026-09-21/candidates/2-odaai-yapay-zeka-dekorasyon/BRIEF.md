# OdaAI – Yapay Zeka ile Oda ve Ev Dekorasyonu

- **Kategori**: günlük-uygulama
- **Slug**: odaai-yapay-zeka-dekorasyon
- **Kaynak stratejisi**: (b) genel küresel trend

## Neden bugün fırsat / neden yükselişte
Almanya Apple "Top Free" listesinde (`rss.marketingtools.apple.com/api/v2/de/apps/top-free/25/apps.json`,
21 Eylül 2026 anlık verisi) **Kling AI: AI Image & Video Maker** #20 sırada; aynı listede
ChatGPT #1, Google Gemini #2, Claude by Anthropic #5 ve Meta AI #24 gibi 5 uygulamanın AI
asistan/üretici kategorisinde olması, genel AI-görsel üretim dalgasının Avrupa pazarında ne
kadar güçlü olduğunu gösteriyor. WebSearch taraması da bunu doğruluyor: "iOS Apple App Store
Statistics and Trends 2026" (42matters.com) ve "Top 50 Trending Apps in 2026" (designveloper.com)
kaynaklarına göre AI asistanları 2026'da "breakout category" (patlama kategorisi) olarak
tanımlanıyor, Google Gemini tek başına 354 milyon indirme almış durumda. Bunun dar/niş bir
uygulaması olan "yapay zeka ile oda/ev yeniden tasarımı" (fotoğraf çek → stil uygula → yeniden
dekore edilmiş görsel al) global ölçekte var olsa da (örn. Interior AI, RoomGPT tarzı ürünler),
Türkiye pazarında yerelleştirilmiş (Türk ev tipleri, TL bazlı mobilya öneri linkleri, Türkçe
stil isimleri) net bir lider yok — bu nedenle esas sinyal genel küresel trend, ikincil olarak
yerel boşluk da mevcut.

## Gelir potansiyeli
Fotoğraf başına "kredi" harcanan IAP modeli (öneri: ilk 3 dönüşüm ücretsiz, sonrası kredi
paketleri) + üst düzey stil paketleri için haftalık/aylık abonelik. Ayrıca önerilen mobilya
ürünlerine affiliate link (yerel e-ticaret ortaklarına yönlendirme — Trendyol/Hepsiburada gibi
platformların ürün linkleri) ek gelir katmanı olabilir. Görsel üretim maliyeti (üçüncü parti AI
görsel API çağrısı) doğrudan kullanım başına olduğundan, kredi bazlı fiyatlama birim ekonomiyi
kontrol altında tutar.

## Çekirdek mekanik / değer önerisi
Kullanıcı odasının fotoğrafını çeker, bir dekorasyon stili seçer (Minimalist, İskandinav,
Bohem, Modern Türk vb.) ve AI görsel dönüşüm API'si üzerinden yeniden tasarlanmış oda görselini
saniyeler içinde görür. Öncesi/sonrası karşılaştırma ekranı ve galeri kaydı ile "hayalimdeki
oda" paylaşılabilir içerik üretir.

## MVP özellik listesi
- Kamera/galeriden fotoğraf yükleme ekranı
- 4-6 dekorasyon stili seçim arayüzü
- Üçüncü parti görsel dönüşüm AI API entegrasyonu (tek sağlayıcı, MVP için yeterli)
- Öncesi/sonrası kaydırmalı karşılaştırma görüntüleyici
- Kredi bazlı kullanım sayacı + IAP kredi paketleri (3 kademe)
- Sonucu galeriye kaydetme / sosyal medyaya paylaşma butonu
- TR/EN dil desteği

## MVP dışı bırakılanlar
- Gerçek mobilya satın alma/affiliate entegrasyonu (faz 2)
- 3D oda modelleme veya AR görünüm
- Çoklu AI sağlayıcı karşılaştırma/otomatik en iyi sonucu seçme
- Kullanıcı hesabı/oda geçmişi senkronizasyonu (bulut)
- Profesyonel tasarımcı ile eşleştirme özelliği

## Checklist sonucu
- Yerel uygunluk: Yüksek — Türkiye'de ev dekorasyonu/yeniden düzenleme ilgisi güçlü (Trendyol,
  Hepsiburada, MediaMarkt gibi ev/mobilya odaklı uygulamaların TR top 25'te olması destekleyici
  sinyal), yerelleştirilmiş net lider uygulama yok.
- Dil/yerelleştirme: Kolay — arayüz metni az, stil isimleri TR/EN olarak kolayca çevrilebilir.
- Mağaza politikası riski: Düşük — kumar/yetişkin/finansal tavsiye kategorisi dışında; kullanıcı
  fotoğrafları için gizlilik politikası ve API sağlayıcı veri işleme şartları netleştirilmeli.
- Çocuk içeriği: yok — genel kitleye yönelik, yaş kısıtı gerekmiyor.
- Teknik fizibilite: Yüksek — Flutter'da kamera/galeri erişimi + tek bir üçüncü parti AI görsel
  API'sine HTTP çağrısı tek oturumda gerçekçi şekilde MVP olarak kurulabilir; kendi ML modeli
  eğitilmiyor.

## Özgünlük Beyanı
Bu konsept, AI görsel üretim/dönüştürme kategorisinden ve global "AI ile oda yeniden tasarımı"
mekaniğinden ilham almıştır; hiçbir isim, marka, logo veya görsel belirli bir rakip
uygulamadan (Kling AI, Interior AI, RoomGPT vb.) kopyalanmamıştır.
