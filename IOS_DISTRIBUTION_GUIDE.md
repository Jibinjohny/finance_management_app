# iOS App Distribution Guide

Complete guide to build and share your CashFlow iOS app with anyone.

---

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Method 1: TestFlight (Recommended)](#method-1-testflight-recommended)
3. [Method 2: Ad Hoc Distribution](#method-2-ad-hoc-distribution)
4. [Method 3: Free Methods (Limited)](#method-3-free-methods-limited)
5. [Building Your iOS App](#building-your-ios-app)
6. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required

- ✅ **Mac Computer** - iOS apps can only be built on macOS
- ✅ **Xcode** - Install from Mac App Store (free)
- ✅ **Flutter SDK** - Already installed ✓
- ✅ **Valid Apple ID** - For code signing

### For Distribution (Choose One)

| Method | Cost | Devices | Expiration | Ease of Sharing |
|--------|------|---------|------------|-----------------|
| **TestFlight** | $99/year | 10,000 | 90 days | ⭐⭐⭐⭐⭐ Just a link |
| **Ad Hoc** | $99/year | 100 | 1 year | ⭐⭐ Need device IDs |
| **AltStore** | Free | Unlimited | 7 days | ⭐ Complex for users |

---

## Method 1: TestFlight (Recommended)

**Best for:** Sharing with many people easily

### What You Need

- Apple Developer Account ($99/year)
- No device IDs needed!
- No jailbreak needed!

### How It Works

1. You upload app to App Store Connect
2. You get a shareable link (like: `https://testflight.apple.com/join/ABC123`)
3. Share link via text, email, WhatsApp, etc.
4. Friends click link → install TestFlight app → install your app
5. Done! ✅

### Step-by-Step

#### Step 1: Get Apple Developer Account

1. Go to [developer.apple.com](https://developer.apple.com)
2. Click **Account** → **Enroll**
3. Pay $99/year
4. Wait for approval (usually 24-48 hours)

#### Step 2: Configure App in Xcode

```bash
# Open project in Xcode
cd /Users/jibinemgenex/Documents/WorkSpace/Ai_WorkSpace/cashflow_app
open ios/Runner.xcworkspace
```

In Xcode:

1. Select **Runner** target
2. Go to **Signing & Capabilities**
3. **Team:** Select your Apple Developer team
4. **Bundle Identifier:** Change to something unique like `com.yourname.cashflow`
5. Ensure **Automatically manage signing** is checked

#### Step 3: Create App in App Store Connect

1. Go to [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. Click **My Apps** → **+** → **New App**
3. Fill in:
   - **Platform:** iOS
   - **Name:** CashFlow (or your preferred name)
   - **Primary Language:** English
   - **Bundle ID:** Select the one you configured in Xcode
   - **SKU:** `cashflow-app-001` (can be anything unique)
   - **User Access:** Full Access
4. Click **Create**

#### Step 4: Build and Upload

In Xcode:

1. Select **Any iOS Device (arm64)** as destination (top bar)
2. Go to **Product** → **Archive**
3. Wait for archive to complete (5-10 minutes)
4. In the Organizer window that appears:
   - Select your archive
   - Click **Distribute App**
   - Choose **App Store Connect**
   - Click **Upload**
   - Click **Next** through all screens
   - Click **Upload**
5. Wait for upload to complete (5-15 minutes)

#### Step 5: Set Up TestFlight

1. Go back to [App Store Connect](https://appstoreconnect.apple.com)
2. Select your app
3. Go to **TestFlight** tab
4. Wait for build to appear (10-30 minutes) and process
5. Once processed, click on the build
6. Under **External Testing**:
   - Click **+** next to **Groups**
   - Create a group (e.g., "Friends")
   - Add test information (what to test)
   - Click **Submit for Review** (lightweight review, 1-2 days)

#### Step 6: Get Shareable Link

Once approved (1-2 days):

1. In TestFlight tab, select your group
2. Click **Public Link** toggle to enable
3. Copy the link: `https://testflight.apple.com/join/XXXXXX`
4. **Share this link with anyone!**

### How Friends Install

1. Click your TestFlight link
2. Install TestFlight app (if not already installed)
3. Click **Accept** → **Install**
4. Done! App installs like any other app

### Updating Your App

1. Make changes to your code
2. Increment version in `pubspec.yaml`: `version: 1.0.1+2`
3. Archive and upload again (Steps 4-5 above)
4. TestFlight users get automatic update notification

---

## Method 2: Ad Hoc Distribution

**Best for:** Small group of specific people (max 100 devices)

### What You Need

- Apple Developer Account ($99/year)
- Device UDIDs from each person
- More complex setup

### Step-by-Step

#### Step 1: Collect Device UDIDs

Each friend needs to send you their device UDID:

**Option A: Using Finder (Mac)**
1. Connect iPhone to Mac
2. Open Finder → Select iPhone
3. Click on device info until UDID appears
4. Right-click UDID → Copy

**Option B: Using Third-Party App**
1. Install "UDID Finder" app from App Store
2. Open app → Copy UDID
3. Send to you

#### Step 2: Register Devices

1. Go to [developer.apple.com/account](https://developer.apple.com/account)
2. **Certificates, IDs & Profiles** → **Devices**
3. Click **+** → **Register Device**
4. Enter:
   - **Device Name:** Friend's name
   - **Device ID (UDID):** Paste UDID
5. Click **Continue** → **Register**
6. Repeat for all friends (max 100 devices)

#### Step 3: Create Ad Hoc Provisioning Profile

1. Still in developer portal: **Profiles** → **+**
2. Select **Ad Hoc** → **Continue**
3. Select your App ID → **Continue**
4. Select your certificate → **Continue**
5. **Select ALL devices** you want to include → **Continue**
6. Profile Name: `CashFlow Ad Hoc`
7. Click **Generate** → **Download**
8. Double-click downloaded profile to install in Xcode

#### Step 4: Build Ad Hoc IPA

In Xcode:

1. Select **Any iOS Device (arm64)**
2. **Product** → **Archive**
3. In Organizer:
   - Select archive
   - Click **Distribute App**
   - Choose **Ad Hoc**
   - Select your Ad Hoc profile
   - Click **Export**
   - Save `.ipa` file to Desktop

#### Step 5: Share IPA File

Upload the `.ipa` file to:
- Google Drive
- Dropbox
- WeTransfer
- Any file sharing service

Share the link with your friends.

#### Step 6: Friends Install

**Option A: Using AltStore (Easiest)**
1. Install AltStore on computer: [altstore.io](https://altstore.io)
2. Download your `.ipa` file
3. Open AltStore → Install `.ipa`

**Option B: Using Sideloadly**
1. Download Sideloadly: [sideloadly.io](https://sideloadly.io)
2. Download your `.ipa` file
3. Connect iPhone to computer
4. Drag `.ipa` into Sideloadly
5. Enter Apple ID → Install

**Option C: Using Diawi (Web-based)**
1. You upload `.ipa` to [diawi.com](https://www.diawi.com)
2. Get shareable link
3. Friends open link in Safari on iPhone
4. Tap **Install**
5. Go to **Settings** → **General** → **VPN & Device Management**
6. Trust your developer certificate

---

## Method 3: Free Methods (Limited)

### AltStore / Sideloadly (No Developer Account)

**Pros:**
- ✅ Completely free
- ✅ No Apple Developer Account needed

**Cons:**
- ❌ App expires every **7 days**
- ❌ Must re-sign every week
- ❌ Friends need computer to install
- ❌ Complex setup

**How It Works:**

1. Build unsigned `.ipa` file
2. Share `.ipa` with friends
3. Friends use AltStore/Sideloadly to sign with their own free Apple ID
4. Must re-sign every 7 days

**Not Recommended** unless you can't afford $99/year.

---

## Building Your iOS App

### Quick Build Commands

```bash
# Navigate to project
cd /Users/jibinemgenex/Documents/WorkSpace/Ai_WorkSpace/cashflow_app

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build iOS app (creates .app bundle, not installable)
flutter build ios --release

# For actual .ipa file, you MUST use Xcode Archive (see above)
```

> ⚠️ **Important:** `flutter build ios` does NOT create an installable `.ipa` file. You must use Xcode's Archive feature.

### Build Script

Save this as `build_ios.sh`:

```bash
#!/bin/bash

echo "🧹 Cleaning previous builds..."
flutter clean

echo "📦 Getting dependencies..."
flutter pub get

echo "🔨 Building iOS release..."
flutter build ios --release --no-codesign

echo "✅ Build complete!"
echo "📱 Now open Xcode to archive and distribute:"
echo "   open ios/Runner.xcworkspace"
```

Make it executable:

```bash
chmod +x build_ios.sh
./build_ios.sh
```

---

## Troubleshooting

### "No valid code signing certificates found"

**Solution:**
1. Open Xcode
2. **Xcode** → **Settings** → **Accounts**
3. Add your Apple ID
4. Select your team → **Manage Certificates**
5. Click **+** → **Apple Development**

### "Failed to register bundle identifier"

**Solution:**
1. Change bundle ID in Xcode to something unique
2. Go to [developer.apple.com](https://developer.apple.com)
3. **Certificates, IDs & Profiles** → **Identifiers** → **+**
4. Register your new bundle ID

### "Provisioning profile doesn't match"

**Solution:**
1. In Xcode: **Product** → **Clean Build Folder**
2. Delete old profiles: `~/Library/MobileDevice/Provisioning Profiles`
3. Re-download from developer portal
4. Rebuild

### "Build failed with code signing error"

**Solution:**
1. Ensure you're signed in to Xcode with Apple ID
2. Select correct team in **Signing & Capabilities**
3. Enable **Automatically manage signing**
4. Clean and rebuild

### TestFlight build stuck in "Processing"

**Solution:**
- Wait 30-60 minutes
- If still stuck after 24 hours, upload a new build with incremented version

---

## Summary

### Recommended Approach

1. **Get Apple Developer Account** ($99/year) - Worth it!
2. **Use TestFlight** - Easiest for everyone
3. **Share simple link** - Friends just click and install
4. **Update easily** - Just upload new builds

### Quick Comparison

| Feature | TestFlight | Ad Hoc | Free (AltStore) |
|---------|-----------|--------|-----------------|
| **Cost** | $99/year | $99/year | Free |
| **Max Users** | 10,000 | 100 | Unlimited |
| **Expiration** | 90 days | 1 year | 7 days |
| **Device IDs** | Not needed | Required | Not needed |
| **Ease** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐ |
| **Re-signing** | No | No | Every 7 days |

---

## Need Help?

Common questions:

**Q: Can I share iOS app without Apple Developer Account?**  
A: Only with AltStore (expires every 7 days, complex for users). Not recommended.

**Q: Is TestFlight the same as App Store?**  
A: No! TestFlight is for beta testing. It's private - only people with your link can install.

**Q: Do I need to publish to App Store?**  
A: No! TestFlight is completely separate. You never have to publish publicly.

**Q: How long does TestFlight review take?**  
A: Usually 1-2 days. Much faster than full App Store review.

**Q: Can I use TestFlight forever?**  
A: Yes, but each build expires after 90 days. Just upload a new build.

---

**Good luck with your iOS distribution! 🚀**
