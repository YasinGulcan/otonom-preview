# Replik – Sohbet Formatında Mikro Diziler

- **Kategori**: günlük-uygulama
- **Slug**: replik-sohbet-mikro-dizi
- **Kaynak stratejisi**: (a) yerel pazar boşluğu (destekleyici sinyal: (b) genel küresel trend)

## Neden bugün fırsat / neden yükselişte
21 Eylül 2026 itibarıyla ABD Apple "Top Free" listesinde iki dikey-video mikro-dizi
uygulaması ilk 25'te yer alıyor: **PineDrama - Short Dramas** (#11) ve **StoryReel: Drama
Shorts & TV** (#18) (kaynak: `rss.marketingtools.apple.com/api/v2/us/apps/top-free/25/apps.json`,
21 Eylül 2026 anlık verisi). WebSearch taraması bu sinyali doğruluyor: "The 2026 Vertical Video
and Micro-Drama Ecosystem" (hillarymarek.substack.com) ve Deadline'ın "Microdramas Go Global"
(deadline.com/2026/01) haberlerine göre kısa-dizi (DramaBox, ReelShort) indirmeleri 2026 Q1'de
850 milyonu aştı (yıllık %140 büyüme) ve global gelir 2026 sonunda 14 milyar dolara ulaşması
bekleniyor. Buna karşın Türkiye Apple "Top Free" listesinde (`.../tr/apps/top-free/25/apps.json`,
aynı tarih) ilk 25'te hiçbir mikro-dizi/dikey-video-dizi uygulaması yok — TR listesi ağırlıklı
e-ticaret (Trendyol, Yemeksepeti, sahibinden, Migros), spor (Mackolik, beIN CONNECT, TOD) ve dil
öğrenme (Learna, Duolingo) uygulamalarından oluşuyor. Bu, ABD'de kanıtlanmış bir formatın
Türkiye'de karşılığının olmadığı net bir yerel boşluk. Video prodüksiyonu (lisanslı oyunculuk,
çekim) tek oturumda MVP kapsamına girmediği için format, aynı "bölüm bölüm, yüksek gerilim,
cliffhanger" dramaturjisini **sohbet/mesajlaşma arayüzünde okunan metin mikro-dizileri**
("chat fiction" — Hooked/Chapters/TapNovel benzeri, ama Türkçe ve yerel temalı) olarak uyarlar;
böylece video lisans/prodüksiyon riski taşımadan aynı davranışsal kancayı (bölüm sonu
cliffhanger + kilit) kopyalar.

## Gelir potansiyeli
Chat-fiction kategorisinde standart model: ilk birkaç bölüm ücretsiz, sonraki bölümler
"jeton/enerji" sistemiyle IAP veya reklam izleyerek açılıyor (rewarded video). Ayrıca
"sınırsız okuma" aylık abonelik üst katman olarak sunulabilir. Düşük geliştirme maliyeti (metin
içerik + basit sohbet UI) ve yüksek günlük geri dönüş potansiyeli (bölüm bekletme mekaniği)
nedeniyle reklam + IAP karma modeli, dizi başına düşük üretim maliyetiyle birleşince kâr marjı
yüksek olabilir.

## Çekirdek mekanik / değer önerisi
Kullanıcı, iki karakter arasındaki WhatsApp/iMessage tarzı sohbeti gerçek zamanlı yazılıyormuş
gibi (yazıyor... animasyonu, sesli mesaj ikonları, fotoğraf balonları) okur; her "bölüm" 2-4
dakikalık bir sohbet akışıdır ve bölüm sonu bir cliffhanger ile biter. Kategori/tür seçimi
(romantik, gerilim, aile dramı) ve günlük bildirim ("Yeni bölüm geldi") ile mikro-dizi
formatının bağımlılık yaratan bekleme/açma döngüsü metin ortamında yeniden kurulur.

## MVP özellik listesi
- 1 pilot dizi, 8-10 bölümlük tam sohbet-formatı script (AI destekli taslak + editör onayı)
- Sohbet balonu animasyonlu okuma ekranı (yazıyor..., okundu biçimi, otomatik ilerleme)
- Bölüm kilidi: ilk 3 bölüm ücretsiz, sonrası jeton ile açılır
- Rewarded video reklam entegrasyonu (jeton kazanma)
- Basit jeton IAP paketleri (3 kademe)
- Günlük "yeni bölüm" push bildirimi
- TR/EN dil anahtarı (metin tabanlı içerik olduğu için düşük maliyetli yerelleştirme)

## MVP dışı bırakılanlar
- Gerçek video/oyunculuk içeriği
- Kullanıcı üretimi içerik (UGC) / dizi yükleme editörü
- Çoklu dizi kütüphanesi ve arama/keşif algoritması
- Sosyal paylaşım / yorum sistemi
- Karakter sesi (TTS) entegrasyonu

## Checklist sonucu
- Yerel uygunluk: Yüksek — Türkçe dizi/pembe dizi kültürü güçlü, format WhatsApp alışkanlığına
  doğrudan oturuyor.
- Dil/yerelleştirme: Kolay — saf metin içerik, TR+EN iki dosya olarak yönetilebilir.
- Mağaza politikası riski: Düşük — kumar/yetişkin içerik yok; script içeriği aile dramı/romantik
  türde tutularak hassas temalardan kaçınılmalı.
- Çocuk içeriği: yok — hedef kitle genel/yetişkin; 12+ yaş derecelendirmesi önerilir (dramatik
  temalar nedeniyle).
- Teknik fizibilite: Yüksek — Flutter'da sohbet balonu UI + zamanlayıcı animasyon tek oturumda
  gerçekçi şekilde MVP olarak çıkarılabilir; ağır video/gerçek zamanlı altyapı gerekmiyor.

## Özgünlük Beyanı
Bu konsept, kısa-dizi (micro-drama) kategorisinin dikkat çekme mekaniğinden ve sohbet-tabanlı
kurgu (chat fiction) formatından ilham almıştır; hiçbir isim, marka, logo veya görsel belirli
bir rakip uygulamadan (PineDrama, StoryReel, DramaBox, ReelShort, Hooked, Chapters vb.)
kopyalanmamıştır.
