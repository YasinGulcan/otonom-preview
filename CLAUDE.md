# Otonom Uygulama Fabrikası — Repo Kuralları

Bu repo, her sabah 9'da otonom çalışan çok-ajanlı bir Flutter uygulama üretim hattının kaynağıdır.
Detaylı mimari: `docs/ARCHITECTURE.md`. Tam plan geçmişi: bu repoyu kuran plan dosyasında.

## Sabit Kurallar (hiçbir ajan bunları ihlal etmez)

1. **Mağaza submission YASAK.** Hiçbir ajan Google Play Console / App Store Connect'e dokunmaz,
   `fastlane deploy`, `fastlane supply` gibi hiçbir yükleme komutu çalıştırmaz. Pipeline
   "build alınmış, test edilmiş, incelemeye hazır" noktasında durur.
2. **iOS build YASAK.** `flutter build ipa` hiçbir zaman çalıştırılmaz (bu ortamda imkansız —
   macOS/Xcode gerektirir). v1 kapsamı sadece Android (`appbundle` + `apk`).
3. **Özgünlük zorunlu.** Hiçbir uygulama; isim, marka, logo veya görsel olarak var olan bir
   rakip uygulamayı kopyalamaz. Trend'den ilham alınır, klonlanmaz. İndirilen telifli
   görsel/logo kullanılmaz — ikonlar/görseller programatik/basit şekillerle üretilir.
4. **Hedef pazar Türkiye.** Uygulamalar Türkçe (+ İngilizce) yerelleştirilebilir ve Türkiye
   kullanıcısı için gerçekten kullanışlı olmalı.
5. **Kapsam disiplini.** MVP en fazla 3-5 ekran (basit oyunlarda 1 ekran + oyun döngüsü).
   Kapsam taşma riski varsa özellik kısılır, oturum uzatılmaz.
6. **QA salt-okunur.** İş Analisti (qa-analyst) bulduğu sorunu kendi düzeltmez, sadece raporlar.

## Ajan Rolleri

- `.claude/skills/team-lead/SKILL.md` — orkestratör, günlük çalışmanın girdiği yer
- `.claude/skills/trend-scout/SKILL.md` — 3 aday konsept üretir
- `.claude/skills/developer/SKILL.md` — seçilen konsepti Flutter ile inşa eder
- `.claude/skills/qa-analyst/SKILL.md` — bağımsız statik QA yapar

## Durum Dosyaları

- `state/trend-history.md` — son ~30 günün kategori geçmişi (tekrar önlemek için)
- `state/run-log.md` — her çalışmanın kısa özet log'u
