# Özet — 2026-09-21 — Tahmin Ligi

## Ne yapıldı
**Tahmin Ligi — Sosyal Süper Lig Tahmin Oyunu** seçildi ve inşa edildi. Kullanıcı, Süper Lig
maçları için gerçek para içermeyen skor tahmini yapıyor, puan kazanıyor, arkadaşlarıyla mini
lig kurup yarışıyor.

**Neden seçildi (İLK İZLENİM — DÜZELTİLDİ, aşağıya bak)**: Türkiye'de futbol takip ilgisinin
güçlü olduğuna dair doğrudan sinyal (Mackolik Live Score, TR Apple Top Free listesinde #4) var;
ilk sunumda bu bir "yerel boşluk" olarak sunulmuştu.

## ⚠️ Düzeltme: "Boşluk" iddiası yanlıştı — gerçek rakipler var

Kullanıcının uyarısı üzerine hedefli bir arama yapıldı ve **bu kategori zaten var olduğu**
görüldü:
- **Süper Lig Tahmin Oyunu** (Google Play) — "gruplar kur, tahmin yap, puan topla" — neredeyse
  birebir aynı mekanik.
- **MaçaKaç** — "Türkiye Süper Ligi'nin Sosyal Ağı" — tahmin et, puan kazan, rozet kazan,
  liderlik tablosunda yüksel — çok benzer.
- **Türkiye Süper Lig Simülasyon** ve **Sosyal Lig** — aynı kategoride, farklı açılardan.

**Sonuç**: Kaynak stratejisi "(a) yerel pazar boşluğu" değil, dürüstçe **"(c) rekabetçi niş"**
olarak düzeltildi. Bu araştırma hatası sisteme kalıcı olarak işlendi (bkz. `CLAUDE.md` +
`trend-scout`/`team-lead` skill'leri) — bundan sonra Trend Scout hedefli arama yapacak VE
Takım Lideri bağımsız ikinci bir doğrulama yapacak, kullanıcıya asla doğrulanmamış bir
"boşluk" iddiası sunulmayacak.

**Karar (kullanıcıyla konuşuldu)**: Buna rağmen devam ediliyor — rekabetin varlığı kategori
talebinin kanıtı olarak okunuyor. Strateji: rakiplerden **çok daha iyi arayüz ve çok daha
kaliteli bir ürünle** farklılaşmak (bkz. aşağıdaki "ileride değerlendirilecek notlar" — cesur
tahmin bonusu, günlük görev/rozet sistemi, coğrafi sıralama gibi zaten konuşulan
farklılaştırıcı özellikler tam da bu yüzden değerli).

## Diğer 2 aday (seçilmedi, ileride tekrar değerlendirilebilir)
1. **Replik — Sohbet Formatlı Mikro Diziler** (günlük-uygulama, yerel boşluk: ABD'de mikro-dizi
   formatı patlıyor, TR'de hiç yok)
2. **OdaAI — Yapay Zeka ile Oda Dekorasyonu** (günlük-uygulama, genel trend: AI görsel üretim
   kategorisi yükselişte)

## Bağlantılar
- [BRIEF.md](BRIEF.md) — konsept detayı
- [QA_REPORT.md](QA_REPORT.md) — test raporu
- [preview.png](preview.png) — ana ekran önizlemesi
- `app/` — Flutter kaynak kodu

## QA Kararı: **PASS**
- `flutter analyze`: temiz
- `flutter test`: 19/19 test geçti
- 7/7 MVP özelliği tam olarak mevcut
- Blocker/Major/Minor sorun: yok
- Özgünlük Beyanı doğrulandı

## Sonradan yapılan tasarım revizyonu (kullanıcıyla konuşulduktan sonra)
Kullanıcıya 3 arayüz yön seçeneği (renk paleti mockup'ı) sunuldu; **"Sahil Yeşili"** (krem +
koyu yeşil) aydınlık mod, **"Gece Modu"** (antrasit + turkuaz) karanlık mod olarak seçildi.
`main.dart`'taki tema, Material3'ün otomatik renk üretimi yerine bu iki paletin tam renk
kodlarıyla (`ColorScheme`, kart/nav bar temaları) yeniden tanımlandı; karanlık/aydınlık geçiş
cihazın sistem ayarına göre otomatik. `flutter analyze` temiz (0 sorun — eski bir test
dosyasındaki 4 deprecated-API uyarısı da bu arada düzeltildi), `flutter test` 19/19 geçti,
`preview.png` ve build'ler yenilendi.

## Sonradan yapılan güvenlik revizyonu (kullanıcıyla konuşulduktan sonra)
QA PASS sonrası, kullanıcıyla mağaza kumar-politikası riski konuşuldu. Ana ekrana **her
sekmede görünen kalıcı bir "Bu bir OYUNdur, gerçek para kullanılmaz" banner'ı** eklendi
(önceden bu uyarı sadece Mini Ligler sekmesinde gömülüydü). Değişiklik sonrası `flutter
analyze`, `flutter test` (19/19, golden görüntü güncellendi) ve her iki build yeniden
çalıştırıldı — hepsi temiz. `preview.png` yeni ekranla güncellendi. Bu kural artık
`CLAUDE.md` ve `trend-scout`/`developer` skill'lerine kalıcı olarak işlendi — ileride
tahmin/puanlama mekanikli her oyunda otomatik uygulanacak.

## Durum
**Kullanıcının manuel testine hazır.** APK doğrudan gönderildi (bu dry-run'da henüz GitHub
Release altyapısı kurulmadığı için `SendUserFile` ile teslim edildi — canlı sistemde bu adım
GitHub Release + bildirimdeki link ile olacak).

## Sabit hatırlatma
iOS build ve Google Play / App Store'a gerçek yükleme bu pipeline'da hiçbir zaman
otomatikleştirilmiyor — ikisi de kullanıcının manuel yapacağı, ayrı adımlar.

## İleride değerlendirilecek notlar (kullanıcıyla konuşuldu, bugünün kapsamına dahil değil)
1. **Sezon dışı boşluk**: Süper Lig yaz aylarında (~Haziran-Ağustos) tatile giriyor, o dönemde
   uygulamada içerik olmayacak. Çözüm adayı: başka bir lig/turnuva ile yaz döneminde devam
   ettirmek.
2. **Cesur tahmin bonusu**: Favoriye karşı sürpriz/zor bir sonucu doğru bilene ekstra puan.
   Veri kaynağı **lig puan durumu/sıralaması** olacak (kim favori, kim değil — herkese açık
   spor verisi), **bahis/iddaa sitelerinden veri çekilmeyecek** (hem izin sorunu hem de
   uygulamayı bahis mantığına yaklaştırma riski taşır). Başlangıçta örnek/sahte veriyle
   gösterilebilir, gerçek kullanıcı verisi şart değil.
3. **Ek tahmin türleri (KG var/yok, toplam gol alt/üst)**: Mekanik olarak sorun yok (dışarıdan
   veri gerekmiyor), ama **İddaa'nın kendi terimleriyle ("KG Var/Yok", "Alt/Üst") sunulmayacak**
   — kullanıcıda bahis kuponu çağrışımı yaratmaması için "İki takım da gol atar mı?", "Toplam
   gol 3'ten az mı çok mu?" gibi sade, kendi dilimizle ifade edilecek.
4. **Coğrafi sıralama (Mahalle → İlçe → İl → Bölge → Türkiye)**: Sosyal/yerel rekabet özelliği,
   bahis riski taşımıyor. Tüm katmanlar korunacak (kullanıcı sadece "genel" değil, kendi
   mahallesinde/ilinde de nerede olduğunu görebilsin). İş modeliyle bağlantısı: Türkiye
   genelinde üst sıralarda görünen biri bunu "göstermek" için rozet/kozmetik satın almak
   isteyebilir — statü güdüsüyle satın alma, kozmetik IAP modelini güçlendiriyor. Gerçek
   çalışması için kullanıcı konumu + gerçek çok kullanıcılı veri gerekiyor (konum izni isteme
   akışı ayrıca düşünülmeli); başlangıçta sahte/örnek veriyle de gösterilebilir, bugünün
   kapsamına girmiyor.
5. **Sohbet (chat)**: Sosyal olarak değerli ama küçük bir ekleme değil — kullanıcılar arası
   mesajlaşma içeren uygulamalar mağazalarda genelde kötüye kullanımı bildirme, kullanıcı
   engelleme ve içerik moderasyonu mekanizmaları zorunlu kılar. Bu yüzden ayrı, kendi başına
   planlanacak bir gelecek aşaması olarak not düşülüyor — bugünün ya da yakın vadenin kapsamına
   girmiyor, moderasyon altyapısı olmadan eklenmeyecek.

6. **Günlük etkileşim özellikleri (MVP sonrası eklenecek)**: Maç olmayan günlerde de kullanıcıyı
   uygulamaya çekmek için — günlük giriş ödülü, günlük futbol sorusu/bilgi yarışması, "bugün
   futbolda" bilgi kartı, görev/rozet sistemi ("3 gün üst üste gir" gibi), arkadaşlarla günlük
   meydan okuma, maç günü canlı takip bildirimi. Hepsi mantıklı bulundu, MVP'den sonraki
   aşamada eklenecek; aynı zamanda daha önce not edilen "sezon dışı boşluk" sorununu da kısmen
   hafifletir (maç olmasa da uygulamada her gün yeni bir şey olur).

7. **Başlangıç (cold-start) stratejisi — Mini Lig öncelikli onboarding**: İlk kullanıcılar
   (kullanıcının arkadaş çevresi) az sayıda olacağı için, uygulama ilk açılışta kullanıcıyı
   "Türkiye geneli" sıralamaya değil, doğrudan **kendi mini ligini kurmaya** yönlendirmeli.
   Küçük bir arkadaş grubunda (15 kişi bile) yarış anlamlı ve dolu hissettirir; binlerce
   kişilik genel tabloda aynı sayı kaybolmuş/motivasyon kırıcı görünür. Davet kodu paylaşımı
   zaten organik büyüme sağlar (arkadaşın arkadaşını davet eder). Genel/Türkiye geneli tablo
   arka planda var olmaya devam eder ama gerçek kalabalık oluşana kadar öne çıkarılmaz.
   MVP sonrası onboarding akışına eklenecek.

## Rakip araştırmasından öğrenilenler (Kuponstar incelemesi)
**Kullanılabilir fikirler**: arkadaşlarla takım/grup kurma (mini lig ile zaten örtüşüyor),
canlı maç takibi/bildirimi, isabet geçmişi/istatistik ekranı ("oran" dili kullanmadan), çoklu
lig desteği (sezon dışı boşluk sorununu çözer, faz 2).

**Kanıtlanmış risk — kesinlikle yapılmayacak**: Kuponstar, gerçek parayla "Elmas Paketi"
(49,99–4.999,99 TL) satıp bunu tahmin parasına çevirdiği için App Store'da **18+ yaş sınırı ve
"Kumar Simülasyonu" içerik etiketi** almış — bu bir ihlal/askıya alma değil, mağazanın bu tür
uygulamalara resmi olarak uyguladığı zorunlu kısıtlama. Bu, daha önce vazgeçtiğimiz "oyuna
para yükleme" kararını somut bir örnekle doğruluyor: gerçek para + tahmin parası birleşirse
18+ etiketi kaçınılmaz oluyor ve kitle daralıyor. Bizim uygulamamızda bu asla olmayacak.

## İkinci rakip araştırması ("Skor Avcısı: Tahmin Oyunu")
Kullanıcının bulduğu bir ekran görüntüsünden incelendi (web aramasında bulunamadı — muhtemelen
çok yeni/küçük, sadece 1 puanı var). Kuponstar'dan farklı olarak bu, bizim pozisyonlamamıza çok
yakın, iyi bir örnek:
- Alt başlığı doğrudan **"Bahissiz Futbol Tahmin Oyunu"**.
- **Yaş sınırı 13+ (18+ değil)** — gerçek para/bahis mekaniği yok teorisini somut şekilde
  doğruluyor (Kuponstar'ın 18+'ı ile tam tersi).
- Uygulama İçi Satın Alımı var ama yine de 13+ kalmış — satın alımın "tahmin parası" değil,
  kozmetik/premium bir şey olduğuna işaret ediyor (bizim planladığımız modelle örtüşüyor).

**Uygulamaya işlenecek kararlar**:
1. Mağaza açıklamasında/alt başlığında **açıkça "bahissiz"** ifadesi kullanılacak (biz de aynı
   netliği baştan vereceğiz).
2. **Çoklu lig desteği önceliği yükseltildi** — bu rakip zaten FA Cup, La Liga, Bundesliga,
   Serie A gösteriyor; bizim faz 2'de planladığımız "sezon dışı boşluk" çözümü aslında pazarda
   zaten bekleniyor, MVP sonrası ilk sırada ele alınmalı.
3. **"Mini Oyunlar" konsepti** not edildi — tahmin dışında ek oyun modları, daha önce konuşulan
   "günlük etkileşim özellikleri" ile birleştirilebilir, MVP sonrası değerlendirilecek.
4. **İkon stili**: Kuponstar'ın karikatürsü/çocuksu tarzı değil ama tamamen kurumsal/soğuk da
   değil — "sıcak ama sade" bir maskot/ikon tarzı iyi bir orta yol olabilir, tasarım aşamasında
   göz önünde bulundurulacak.

## Değerlendirilip vazgeçilen fikir
**"Oyun para yükle" (genel cüzdan/top-up sistemi)**: Kullanıcıyla tartışıldı ve vazgeçildi —
gerçek bahis oynamak isteyen zaten İddaa'ya gider (orada gerçek kazanma ihtimali var); bizim
uygulamamıza para yükleyip hiçbir şey "kazanamamak" mantıksız, hem kullanılmaz hem de gereksiz
bir kumar-benzeri yapı riski taşır. Bunun yerine mevcut model (reklamla jeton kazan + doğrudan
tek seferlik kozmetik satın alma + VIP abonelik) korunuyor.
