# QA Raporu — 2026-09-21 / tahmin-ligi-futbol-oyunu

## Genel Karar: PASS

Tüm kontroller başarıyla tamamlandı. Uygulama MVP özelliklerini tamamen gerçekleştirmekte, test kapsamı güçlü ve build artifacts geçerlidir.

## Kontrol Tablosu
| Kontrol | Sonuç |
|---|---|
| flutter analyze | ✓ Hata yok (5.8s içinde tamamlandı) |
| flutter test | ✓ 19 test geçti (app_state: 10, scoring: 2, widget: 3, golden: 1, widget_basic: 3) |
| .aab | ✓ Var, 46.81 MB (build/app/outputs/bundle/release/app-release.aab) |
| .apk | ✓ Var, 47.67 MB (build/app/outputs/flutter-apk/app-release.apk) |
| Özgünlük Beyanı | ✓ Doğrulandı — hiçbir kodu kopya yok; gerçek Türk futbol takımları (Galatasaray, Fenerbahçe, Beşiktaş, vb.), gerçek para bahis unsuru tamamen çıkarılmış |

## Özellik Eşleşmesi (BRIEF.md'ye göre)
| Özellik | Durum | Açıklama |
|---|---|---|
| Haftalık Süper Lig fikstürü listesi (statik veri) | Var | FixturesTab haftaya göre organize edilmiş maçları gösterir; fixtures_data.dart statik veri tutmakta |
| Skor tahmin girişi ekranı (maç başlamadan kilitlenir) | Var | match_card.dart _PredictionEntry widget skor için stepper sunmakta; isLocked() maçın kilitli durumunu kontrol etmekte |
| Puanlama motoru (doğru sonuç/tam skor için farklı puan) | Var | scoring.dart calculatePoints() — tam skor: 3 puan, doğru sonuç: 1 puan, yanlış: 0 puan |
| Genel liderlik tablosu (haftalık + sezonluk) | Var | leaderboard_tab.dart SegmentedButton ile haftalık/sezonluk toggle; leaderboard() metoduyla puanlama |
| Arkadaşlarla davet kodlu mini lig oluşturma | Var | mini_leagues_tab.dart createMiniLeague() ve joinMiniLeagueByCode() mekanizması; otomatik kod üretimi |
| Rewarded video ile ekstra tahmin hakkı | Var | match_card.dart _SubmittedAwaitingEdit — watchRewardedAdToUnlockEdit() 900ms gerçekleştirme; MVP'de mock reklam |
| TR/EN dil desteği | Var | main.dart supportedLocales [tr, en]; l10n/strings.dart 38 anahtar için çeviri; toggleLocale() işlevi |

## Hata Listesi
- **Blocker**: Hiçbiri
- **Major**: Hiçbiri
- **Minor**: Hiçbiri

### Detaylar:
- Kod taraması: TODO/FIXME yok
- Test kapsamı: Kilitleme davranışı, puanlama kuralları, dil değişimi, tab navigasyonu kapsanmış
- Build artifacts: 46–47 MB; daha da iyileştirilebilir ama MVP için kabul edilebilir

## Önizleme
`preview.png` — Ana ekran (FixturesTab) golden test üretimine göre; 1080×2160 dp'de render; Hafta 5'in "Kilitli" ve "Henüz başlamamış" maçlarını göstermekte.

## Takım Lideri'ne Öneri
**Kullanıcının manuel testine hazır.** Headless testler ve build artifacts temiz; uygulama gerçek cihazda tahmin, puanlama, mini lig oluşturma ve dil değiştirme işlevleriyle kullanılabilir durumdadır.
