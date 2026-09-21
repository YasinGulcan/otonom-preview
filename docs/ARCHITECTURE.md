# Mimari

## Özet

Bu sistemde kalıcı, adlandırılmış "arka planda yaşayan" ajanlar yoktur. Her sabah 9'daki
otonom tetikleme, hafızası olmayan yepyeni bir bulut oturumudur ("Takım Lideri"). Takım Lideri
kendi içinde, sırayla, üç alt ajanı `Agent` tool'uyla spawn eder (Trend Scout → Developer →
QA Analyst) — her biri bir öncekinin çıktısına bağımlı olduğu için paralel değil, sıralıdır.

Günler arası tek "hafıza" disk üzerindeki dosyalardır (`state/trend-history.md`,
`state/run-log.md`) — ajanların kendisinde kalıcı bellek yoktur.

## Günlük Akış

1. **09:00** — zamanlanmış bulut rutini `team-lead/SKILL.md`'yi tetikler.
2. **Trend Scout** spawn edilir → 3 aday konsept (`apps/<tarih>/candidates/<n>-<slug>/BRIEF.md`)
   üretir. Stratejisi ikili: (a) ABD/AB'de tutan ama Türkiye'de karşılığı olmayan/zayıf bir
   konsepti yerelleştirme fırsatı, (b) genel küresel yükselen trend. Her BRIEF; kaynak
   stratejisi, "neden fırsat" gerekçesi, gelir potansiyeli değerlendirmesi ve bir Özgünlük
   Beyanı içerir.
3. **Seçim** — Takım Lideri, Remote Control üzerinden kullanıcının telefonuna 3 adayı
   (gerekçe + gelir özetiyle) sunan bir bildirim/soru gönderir ve **süresiz** cevap bekler
   (otomatik zaman aşımı yoktur — bulut rutini platformunun kendi maksimum çalışma süresi
   dışsal bir sınır olabilir, bu canlıya geçtikten sonra gözlemlenmelidir).
4. Kullanıcı seçince, seçilen adayın `BRIEF.md`'si `apps/<tarih>/<slug>/`'a taşınır.
5. **Developer** spawn edilir → Flutter projesini kurar, BRIEF'teki MVP'yi (kategoriye göre
   Oyun ya da Günlük Uygulama playbook'unu izleyerek) implement eder, `.aab` ve `.apk` üretir.
6. **QA Analyst** spawn edilir → bağımsız, headless statik QA yapar (analyze/test tekrar
   çalıştırılır, özellik-BRIEF eşleşmesi kontrol edilir, golden-test ile `preview.png` üretilir),
   `QA_REPORT.md` yazar.
7. QA FAIL değilse, o günün `.apk`'si bir GitHub Release'e asset olarak yüklenir.
8. Takım Lideri `SUMMARY.md`'yi yazar, APK indirme linkiyle birlikte tamamlanma bildirimini
   gönderir, günün dosyalarını commit+push eder.

## Model Seçimi (Token/Kaynak Yönetimi)

- Trend Scout, Developer → Sonnet (akıl yürütme/kod kalitesi kritik)
- QA Analyst → Haiku 4.5 (mekanik checklist işi; dry-run'da yetersiz çıkarsa Sonnet'e yükseltilir)
- Takım Lideri → üst oturumun kendisi (Sonnet)

## Bilinen Sınırlamalar

- **iOS**: bu ortamda build alınamaz (Xcode/macOS gerektirir). İleride bir Mac veya macOS CI
  (Codemagic / GitHub Actions macOS runner / Fastlane) gerekir.
- **QA**: tamamen headless — gerçek emulator/cihaz yok, gerçek dokunmatik testi kullanıcı
  telefonundan kendisi yapar.
- **Mağaza submission**: hiçbir aşamada otomatikleştirilmez, kullanıcı manuel yapar.

## Kapsam Dışı / Gelecek Takip İşleri

- iOS build otomasyonu.
- Gerçek Google Play / App Store submission otomasyonu (API kimlik bilgileri kurulduğunda).
- QA FAIL sonucunda Developer'a otomatik geri bildirim döngüsü (v1 tek geçişli).
- **Mağaza politikası riski**: Google Play ve App Store, tek bir geliştirici hesabından kısa
  sürede birbirine benzer/şablon gibi görünen çok sayıda basit uygulama yayınlanmasını
  "spam / minimum işlevsellik" politikası kapsamında değerlendirip hesabı askıya alabilir.
  "Her gün 1 uygulama üret" ile "her gün 1 uygulama yayınla" aynı şey değildir — kullanıcı,
  üretilen uygulamalardan hangisini ne zaman/hangi hesaptan yayınlayacağına yayınlama
  aşamasında kendisi karar verir (örn. birden fazla hesaba dağıtarak hesap başına yayınlama
  sıklığını azaltmak). Bu, üretim pipeline'ının tasarımını etkilemez.
