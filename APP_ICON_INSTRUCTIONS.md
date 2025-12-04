# CashFlow App Icon Installation

## Icon Location
The app icon has been generated and saved at:
`/Users/jibinemgenex/.gemini/antigravity/brain/2737b936-cafe-438e-82de-8336a5cb4f11/cashflow_app_icon_1763554729725.png`

## Installation Steps

### For Android:
1. Use an online tool like [App Icon Generator](https://appicon.co/) or [Android Asset Studio](https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html)
2. Upload the generated icon image
3. Download the generated Android icon pack
4. Replace the contents of `android/app/src/main/res/` with the generated mipmap folders

### For iOS:
1. Use the same icon generator tools mentioned above
2. Generate iOS icon set
3. Replace the contents of `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

### Quick Method (Using flutter_launcher_icons package):
1. Add to `pubspec.yaml`:
```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"
```

2. Create `assets/icon/` directory and copy the icon there as `app_icon.png`
3. Run: `flutter pub get`
4. Run: `flutter pub run flutter_launcher_icons`

## Icon Design Features
- Dark gradient background (deep blue to purple)
- Glowing neon green upward arrow/flow symbol
- Glassmorphic effect with frosted glass texture
- Rupee symbol (₹) integrated into design
- Premium look with soft glow effects
- 1024x1024 resolution
