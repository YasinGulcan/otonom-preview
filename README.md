# Otonom Uygulama Fabrikası

Her sabah 9'da otonom olarak çalışan, Türkiye pazarına yönelik bir Flutter uygulama fikri bulup
(oyun ya da günlük kullanım uygulaması), geliştirip, test eden ve kullanıcıya telefonundan
seçim yaptırıp sonunda sideload edilebilir bir APK teslim eden çok ajanlı bir sistem.

Mimari ve akış detayları için: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

## Klasör Yapısı

- `.claude/skills/` — dört ajan rolünün (team-lead, trend-scout, developer, qa-analyst) talimatları
- `apps/<tarih>/` — o günün adayları ve seçilen uygulamanın kaynak kodu, test raporu, özeti
- `state/` — günler arası hafıza (trend geçmişi, çalışma log'u)
- `docs/` — mimari dokümantasyonu

## Kapsam Dışı (şimdilik)

- iOS build (macOS/Xcode gerektirir)
- Google Play / App Store'a otomatik yükleme (submission manuel)
