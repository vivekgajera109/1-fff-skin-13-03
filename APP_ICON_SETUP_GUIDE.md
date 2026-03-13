# App Icon Setup Guide - FFF Skin Tool

## 📱 Your Logo
You have a beautiful gaming logo with:
- Glowing cyan diamond
- Treasure chest with gems
- "FFF SKIN TOOL" text
- "DIAMOND UNLOCK" subtitle
- Dark blue/purple gradient background

---

## 🚀 Quick Setup (Recommended - Automated)

### Method 1: Using flutter_launcher_icons Package

This is the **easiest and fastest** method.

#### Step 1: Add the package to pubspec.yaml

Add this to your `pubspec.yaml` under `dev_dependencies`:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  flutter_launcher_icons: ^0.13.1  # Add this line
```

#### Step 2: Configure the icon

Add this configuration at the bottom of `pubspec.yaml`:

```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icons/app_icon.png"
  adaptive_icon_background: "#0A0E1A"
  adaptive_icon_foreground: "assets/icons/app_icon_foreground.png"
  
  # Optional: Remove default Flutter icon
  remove_alpha_ios: true
```

#### Step 3: Prepare your logo

1. Save your logo image as: `assets/icons/app_icon.png`
   - Size: **1024x1024 pixels**
   - Format: PNG with transparency (if needed)

2. (Optional) Create a foreground version: `assets/icons/app_icon_foreground.png`
   - Size: **1024x1024 pixels**
   - Only the icon without background (for Android adaptive icons)

#### Step 4: Run the generator

Open terminal and run:

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

This will automatically generate all required icon sizes for both Android and iOS!

---

## 📐 Manual Setup (Advanced)

If you prefer to do it manually or need more control:

### Android Icon Sizes Required

Place your icon in these folders with these sizes:

| Folder | Size | File Name |
|--------|------|-----------|
| `mipmap-mdpi` | 48x48 | `ic_launcher.png` |
| `mipmap-hdpi` | 72x72 | `ic_launcher.png` |
| `mipmap-xhdpi` | 96x96 | `ic_launcher.png` |
| `mipmap-xxhdpi` | 144x144 | `ic_launcher.png` |
| `mipmap-xxxhdpi` | 192x192 | `ic_launcher.png` |

**Paths:**
```
android/app/src/main/res/mipmap-mdpi/ic_launcher.png
android/app/src/main/res/mipmap-hdpi/ic_launcher.png
android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
```

### iOS Icon Sizes Required

For iOS, you need multiple sizes in `ios/Runner/Assets.xcassets/AppIcon.appiconset/`:

| Size | File Name | Purpose |
|------|-----------|---------|
| 20x20 | `Icon-App-20x20@1x.png` | Notifications |
| 40x40 | `Icon-App-20x20@2x.png` | Notifications @2x |
| 60x60 | `Icon-App-20x20@3x.png` | Notifications @3x |
| 29x29 | `Icon-App-29x29@1x.png` | Settings |
| 58x58 | `Icon-App-29x29@2x.png` | Settings @2x |
| 87x87 | `Icon-App-29x29@3x.png` | Settings @3x |
| 40x40 | `Icon-App-40x40@1x.png` | Spotlight |
| 80x80 | `Icon-App-40x40@2x.png` | Spotlight @2x |
| 120x120 | `Icon-App-40x40@3x.png` | Spotlight @3x |
| 120x120 | `Icon-App-60x60@2x.png` | App Icon @2x |
| 180x180 | `Icon-App-60x60@3x.png` | App Icon @3x |
| 1024x1024 | `Icon-App-1024x1024@1x.png` | App Store |

---

## 🛠️ Tools to Resize Your Logo

### Option 1: Online Icon Generators (Easiest)

**1. AppIcon.co** (Recommended)
- URL: https://www.appicon.co/
- Upload your 1024x1024 logo
- Download all sizes for Android & iOS
- Free and fast

**2. MakeAppIcon**
- URL: https://makeappicon.com/
- Upload 1024x1024 image
- Get all required sizes
- Free

**3. Icon Kitchen**
- URL: https://icon.kitchen/
- Android adaptive icons
- Preview on different devices
- Free

### Option 2: Using Image Editing Software

**Photoshop/GIMP:**
1. Open your 1024x1024 logo
2. Image → Image Size
3. Resize to each required dimension
4. Save as PNG
5. Repeat for all sizes

**Batch Resize Tools:**
- **XnConvert** (Free, Windows/Mac/Linux)
- **ImageMagick** (Command line)
- **Bulk Resize Photos** (Online)

---

## 📋 Step-by-Step: Using flutter_launcher_icons (Recommended)

### Complete Walkthrough:

**1. Create icons folder:**
```bash
mkdir assets/icons
```

**2. Save your logo:**
- Save the image you showed me as `app_icon.png`
- Place it in: `assets/icons/app_icon.png`
- Make sure it's 1024x1024 pixels

**3. Update pubspec.yaml:**

Add to `dev_dependencies`:
```yaml
flutter_launcher_icons: ^0.13.1
```

Add at the bottom of the file:
```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icons/app_icon.png"
  adaptive_icon_background: "#0A0E1A"  # Your dark blue background
  adaptive_icon_foreground: "assets/icons/app_icon.png"
```

**4. Run commands:**
```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

**5. Verify:**
- Check `android/app/src/main/res/mipmap-*/` folders
- Check `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
- Icons should be generated!

**6. Test:**
```bash
flutter run
```
Check the app icon on your device/emulator.

---

## 🎨 Android Adaptive Icons (Modern Android)

For modern Android (8.0+), you can create adaptive icons:

### What are Adaptive Icons?
- Foreground layer (your icon)
- Background layer (solid color or image)
- System applies shape (circle, square, squircle)

### Setup:

**1. Create foreground image:**
- Size: 1024x1024
- Only the main icon elements (diamond + chest)
- Transparent background
- Save as: `assets/icons/app_icon_foreground.png`

**2. Update pubspec.yaml:**
```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icons/app_icon.png"
  adaptive_icon_background: "#0A0E1A"  # Dark blue
  adaptive_icon_foreground: "assets/icons/app_icon_foreground.png"
```

**3. Regenerate:**
```bash
flutter pub run flutter_launcher_icons
```

---

## ✅ Checklist

- [ ] Logo saved as 1024x1024 PNG
- [ ] Placed in `assets/icons/app_icon.png`
- [ ] Added `flutter_launcher_icons` to `pubspec.yaml`
- [ ] Configured icon settings in `pubspec.yaml`
- [ ] Ran `flutter pub get`
- [ ] Ran `flutter pub run flutter_launcher_icons`
- [ ] Tested on Android device/emulator
- [ ] Tested on iOS device/simulator (if applicable)
- [ ] Verified icon appears correctly
- [ ] Checked adaptive icon on Android 8.0+

---

## 🐛 Troubleshooting

### Icon not showing after setup:

**1. Clean and rebuild:**
```bash
flutter clean
flutter pub get
flutter run
```

**2. Uninstall app from device:**
- Manually uninstall the app
- Reinstall with `flutter run`

**3. Check file paths:**
- Ensure `assets/icons/app_icon.png` exists
- Verify path in `pubspec.yaml` is correct

**4. Verify image format:**
- Must be PNG format
- Should be 1024x1024 pixels
- Check file isn't corrupted

### Android icon not updating:

**1. Clear build cache:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter run
```

**2. Check AndroidManifest.xml:**
File: `android/app/src/main/AndroidManifest.xml`

Should have:
```xml
<application
    android:icon="@mipmap/ic_launcher"
    ...>
```

### iOS icon not updating:

**1. Clean iOS build:**
```bash
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..
flutter clean
flutter run
```

**2. Check Info.plist:**
File: `ios/Runner/Info.plist`

Should reference the icon set correctly.

---

## 📱 Testing Your Icon

### Android:
1. Build and install: `flutter run`
2. Go to home screen
3. Check app drawer
4. Long-press icon to see adaptive icon behavior
5. Test on different Android versions (8.0+, 12+)

### iOS:
1. Build and install: `flutter run`
2. Go to home screen
3. Check icon appearance
4. Test on different iOS versions (14+, 15+, 16+)

---

## 🎯 Quick Command Reference

```bash
# Install dependencies
flutter pub get

# Generate icons automatically
flutter pub run flutter_launcher_icons

# Clean project
flutter clean

# Run app
flutter run

# Build APK
flutter build apk

# Build iOS
flutter build ios
```

---

## 📞 Need Help?

If you encounter issues:

1. **Check package version:**
   - Ensure `flutter_launcher_icons` is latest version
   - Run: `flutter pub upgrade flutter_launcher_icons`

2. **Verify Flutter version:**
   ```bash
   flutter --version
   ```

3. **Check for errors:**
   - Read terminal output carefully
   - Look for file path errors
   - Verify image format and size

---

**Ready to set up your icon?**

Just follow the "Quick Setup" section above, and your beautiful gaming logo will be set as your app icon in minutes! 🚀
