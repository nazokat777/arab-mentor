# 🍎 iOS Configuration

Bu fayl `flutter create .` ishlatilgandan keyin **iOS sozlamalari** uchun yo'riqnoma.

## 1. Bundle Identifier

`ios/Runner.xcodeproj/project.pbxproj` faylida:
```
PRODUCT_BUNDLE_IDENTIFIER = com.mnsm.arabmentor;
```

Bu GitHub Actions tomonidan avtomatik o'rnatiladi (`flutter create . --org com.mnsm`).

## 2. Display Name

`ios/Runner/Info.plist` faylida:
```xml
<key>CFBundleDisplayName</key>
<string>Arab Mentor</string>
<key>CFBundleName</key>
<string>arab_mentor</string>
```

## 3. iOS Permissions (Info.plist)

TTS va audio uchun `ios/Runner/Info.plist` ichiga qo'shing:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>Talaffuz mashqi uchun mikrofon kerak</string>

<key>NSSpeechRecognitionUsageDescription</key>
<string>Talaffuz tahlili uchun nutq tanish kerak</string>
```

## 4. Minimum iOS version

`ios/Podfile` faylida:
```ruby
platform :ios, '12.0'
```

## 5. App Icon va Launch Screen

Logoni qo'shgach:
- `assets/images/mnsm_logo.png` faylini PNG sifatida saqlang
- iOS ikonlari uchun: [appicon.co](https://appicon.co) saytida 1024x1024 PNG yuklang
- Yuklab olingan papkani `ios/Runner/Assets.xcassets/AppIcon.appiconset/` ichiga ko'chiring

## 6. App Store'ga chiqarish (uzoq muddatli)

1. **Apple Developer akkaunt** oching ($99/yil) — [developer.apple.com](https://developer.apple.com)
2. App Store Connect'da yangi ilova yarating
3. Bundle ID: `com.mnsm.arabmentor`
4. GitHub Actions'ga **signing certificate** qo'shing (secrets'da)
5. `flutter build ipa --release` build qilib App Store Connect'ga yuboring
