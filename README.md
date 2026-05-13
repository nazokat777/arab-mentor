# 🕌 Arab Mentor — Interaktiv Arab Tili O'rganish Ilovasi

> Android va iOS uchun mo'ljallangan, Islamic Art uslubidagi to'liq interaktiv arab tili o'rganish ilovasi.

Mukammal arab grammatikasini (Nahv, Sarf, Tarkib) **0 dan mukammallikkacha** o'rgatuvchi mobile ilova. MIT'ning *Mastery-Based Learning* va *Differential Learning* metodikalari asosida.

---

## ✨ Asosiy xususiyatlari

- 🎴 **Flashcard tizimi** — flip-animatsiyali so'z kartochkalari, audio talaffuz bilan
- 🎮 **3 ta interaktiv o'yin:**
  - So'z moslash (Word Match)
  - Gap yasash (Sentence Builder)
  - I'rob tahlili (Grammar Analysis)
- 📚 **5+ to'liq dars:** Mubtado-Xabar, Muzakkar-Muannas, Mufrad-Musanno-Jam', Kalom-Kalima, Ismli/Fe'lli gap
- 🔥 **Streak tizimi** — kunlik mashqlar uchun
- 💎 **XP & gavhar tizimi** — gamifikatsiya
- 🔊 **Audio talaffuz** — Flutter TTS bilan har bir so'zni eshitish
- 🎯 **100% Mastery Gate** — keyingi darsga o'tish uchun barcha savollarni to'g'ri javob berish kerak
- 🎨 **Islamic Art dizayn** — yashil-oltin palette, geometric pattern fonlar, Amiri shrifti
- 📱 **Android + iOS** — bir kodbazadan ikkala platforma uchun

---

## 📖 Manba kitoblar

1. M. Hasanov — *Arab tili darslari*
2. S. Bekpo'lat — *Mabdaun Nahv & Mabdaul Qiroat*
3. D. N. Bodariy — *Mukammal Sarf darsligi*
4. TIU — *Tarkib qoidalari*

---

## 🚀 Ishga tushirish

### 1-qadam: Flutter o'rnatish

[Flutter SDK'ni rasmiy saytdan yuklab oling →](https://docs.flutter.dev/get-started/install)

Windows'da `flutter` buyrug'i ishlashini tekshiring:

```powershell
flutter --version
flutter doctor
```

### 2-qadam: Dependenslarni o'rnatish

Loyiha papkasiga o'ting:

```powershell
cd "c:\Users\User\Desktop\arab mentor"
flutter pub get
```

### 3-qadam: Ilovani ishga tushirish

**Telefonni USB orqali ulang** (Developer Mode yoqilgan bo'lsin) yoki **emulyator** oching, keyin:

```powershell
flutter run
```

### 📦 Build qilish

**Android APK:**
```powershell
flutter build apk --release
```
Natija: `build/app/outputs/flutter-apk/app-release.apk`

**iOS (faqat Mac'da):**
```bash
flutter build ios --release
```

---

## 🗂 Loyiha tuzilmasi

```
arab_mentor/
├── lib/
│   ├── main.dart                    # Kirish nuqtasi
│   ├── theme/
│   │   └── app_theme.dart           # Islamic Art palette
│   ├── models/
│   │   ├── lesson.dart              # Dars modeli
│   │   ├── word.dart                # So'z modeli
│   │   └── user_progress.dart       # Progress modeli
│   ├── data/
│   │   ├── lessons_data.dart        # Darslar mazmuni
│   │   └── vocabulary.dart          # Lug'at
│   ├── services/
│   │   ├── progress_service.dart    # XP, streak, level
│   │   └── audio_service.dart       # TTS audio
│   ├── widgets/
│   │   ├── geometric_pattern.dart   # Islamic star pattern
│   │   └── stat_widgets.dart        # Badge'lar
│   └── screens/
│       ├── splash_screen.dart
│       ├── home_screen.dart
│       ├── lessons_screen.dart
│       ├── lesson_detail_screen.dart
│       ├── flashcard_screen.dart
│       ├── profile_screen.dart
│       ├── games_screen.dart
│       └── games/
│           ├── word_match_game.dart
│           ├── sentence_builder_game.dart
│           └── irab_game.dart
└── pubspec.yaml
```

---

## 🎨 Dizayn tizimi

| Rang | Hex | Ishlatilishi |
|------|-----|--------------|
| 🟢 Emerald | `#1B4332` | Asosiy rang, gradient |
| 🟢 Forest Green | `#2D6A4F` | Ikkilamchi yashil |
| 🟡 Gold | `#D4A574` | Aksent, borders, badge |
| 🟡 Gold Light | `#F1D5A6` | Ochiq oltin |
| 🟤 Soft Brown | `#6B4423` | Matn, kalligrafiya |
| 🥚 Cream | `#FAF3E7` | Fon |
| 🥚 Ivory | `#FFF8E7` | Karta foni |
| 🔴 Deep Red | `#8B2331` | Xato, ogohlantirish |

**Shriftlar:**
- Arabcha: **Amiri** (Google Fonts)
- O'zbekcha: **Merriweather** (Google Fonts)

---

## 🛠 Texnologiyalar

- **Flutter 3.5+** — UI framework
- **Provider** — state management
- **shared_preferences** — progress saqlash
- **flutter_tts** — audio talaffuz
- **google_fonts** — shriftlar
- **flutter_animate** — animatsiyalar
- **confetti** — yutuq effekti

---

## 📜 Litsenziya

Ta'lim maqsadlarida bepul foydalanish uchun.

---

## 🙏 Da'vat

> **وَقُل رَّبِّ زِدْنِي عِلْمًا**
>
> *"Rabbim, ilmimni ziyoda qilgin"* — Toha surasi: 114
