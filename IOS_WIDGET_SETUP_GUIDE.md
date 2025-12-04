# iOS Widget Setup Guide

## Problem

Your iOS widget is not showing up because the widget code exists in the `Runner` folder but **iOS widgets require a separate Widget Extension target** in Xcode. Currently, `HomeWidget.swift` is just a file in the main app, not a proper widget extension.

## Solution

You need to create a **Widget Extension** in Xcode. Unfortunately, this **cannot be automated** via command line - you must use Xcode.

---

## Step-by-Step Setup (Must be done in Xcode)

### Step 1: Open Project in Xcode

```bash
cd /Users/jibinemgenex/Documents/WorkSpace/Ai_WorkSpace/cashflow_app
open ios/Runner.xcworkspace
```

> ⚠️ **Important:** Open the `.xcworkspace` file, NOT the `.xcodeproj` file!

---

### Step 2: Create Widget Extension

1. In Xcode, go to **File → New → Target**
2. Select **Widget Extension** (under iOS → Application Extension)
3. Click **Next**
4. Configure the widget:
   - **Product Name:** `CashFlowWidget`
   - **Team:** Select your Apple Developer team
   - **Include Configuration Intent:** ❌ Uncheck this
   - Click **Finish**
5. When asked "Activate 'CashFlowWidget' scheme?", click **Activate**

---

### Step 3: Configure App Groups

Both your main app and widget need to share data via App Groups.

#### 3a. Enable App Groups for Main App (Runner)

1. Select **Runner** target in Xcode
2. Go to **Signing & Capabilities** tab
3. Click **+ Capability**
4. Add **App Groups**
5. Click **+** and create: `group.com.example.cashflow_app`
6. Check the checkbox next to it

#### 3b. Enable App Groups for Widget

1. Select **CashFlowWidget** target
2. Go to **Signing & Capabilities** tab
3. Click **+ Capability**
4. Add **App Groups**
5. Check the same group: `group.com.example.cashflow_app`

---

### Step 4: Replace Widget Code

1. In Xcode's Project Navigator, find the **CashFlowWidget** folder
2. Delete the auto-generated files:
   - `CashFlowWidget.swift`
   - `CashFlowWidgetBundle.swift` (if exists)
3. Copy your existing `HomeWidget.swift` file into the **CashFlowWidget** target:
   - Right-click **CashFlowWidget** folder → **Add Files to "CashFlowWidget"**
   - Select `/Users/jibinemgenex/Documents/WorkSpace/Ai_WorkSpace/cashflow_app/ios/Runner/HomeWidget.swift`
   - **Important:** Check **Copy items if needed**
   - Under **Add to targets**, check **CashFlowWidget** only
   - Click **Add**

---

### Step 5: Update Info.plist (Widget)

1. Select **CashFlowWidget** target
2. Find `Info.plist` in the CashFlowWidget folder
3. Verify these keys exist:
   - `NSExtension` → `NSExtensionPointIdentifier` = `com.apple.widgetkit-extension`
   - `CFBundleDisplayName` = `CashFlow Expenses`

---

### Step 6: Update Podfile

Add widget target to your Podfile. Open `ios/Podfile` and add this **before** the `post_install` block:

```ruby
target 'CashFlowWidget' do
  use_frameworks!
  # Add any pods the widget needs here if necessary
end
```

Then run:

```bash
cd ios
pod install
```

---

### Step 7: Build and Run

1. In Xcode, select **Runner** scheme (top left)
2. Select your device or simulator
3. Click **Run** (▶️)
4. Once the app launches, go to your home screen
5. Long-press the home screen → tap **+** (top left)
6. Search for **CashFlow**
7. Select **CashFlow Expenses** widget
8. Choose **Medium** size
9. Tap **Add Widget**

---

## Troubleshooting

### Widget doesn't appear in widget gallery

- Make sure you selected the **CashFlowWidget** target when adding `HomeWidget.swift`
- Verify App Groups are enabled for both targets with the same group ID
- Clean build folder: **Product → Clean Build Folder** in Xcode
- Rebuild the app

### Widget shows "No expense data"

- Make sure the app is running and has transactions
- Check that `HomeWidgetService.updateData()` is being called in your Flutter app
- Verify the App Group ID matches in both Swift code and Flutter code

### Build errors

- Make sure you opened `.xcworkspace`, not `.xcodeproj`
- Run `pod install` in the `ios` folder
- Clean and rebuild

---

## Why This Can't Be Automated

iOS Widget Extensions require:
- Xcode project file modifications (`.pbxproj`)
- Code signing configuration
- Target dependencies
- Build phases setup

These are complex binary/XML files that are error-prone to edit manually. Apple recommends using Xcode GUI for creating extensions.

---

## Alternative: Use home_widget Plugin Properly

The `home_widget` plugin you're using should handle this automatically, but it requires running a setup command:

```bash
cd /Users/jibinemgenex/Documents/WorkSpace/Ai_WorkSpace/cashflow_app
flutter pub run home_widget:generate
```

However, this may not work perfectly and you'll likely still need to configure it manually in Xcode as described above.

---

## Summary

**Quick Steps:**
1. Open `ios/Runner.xcworkspace` in Xcode
2. Create Widget Extension target named `CashFlowWidget`
3. Enable App Groups for both Runner and CashFlowWidget: `group.com.example.cashflow_app`
4. Move `HomeWidget.swift` to CashFlowWidget target
5. Update Podfile to include CashFlowWidget target
6. Run `pod install`
7. Build and run

Once set up, your widget should appear in the widget gallery! 🎉
