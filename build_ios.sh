#!/bin/bash

# iOS Build Script for CashFlow App
# This script prepares the iOS build and opens Xcode for archiving

set -e  # Exit on error

echo "🚀 CashFlow iOS Build Script"
echo "================================"
echo ""

# Navigate to project directory
PROJECT_DIR="/Users/jibinemgenex/Documents/WorkSpace/Ai_WorkSpace/cashflow_app"
cd "$PROJECT_DIR"

echo "📍 Working directory: $PROJECT_DIR"
echo ""

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
echo "✅ Clean complete"
echo ""

# Get dependencies
echo "📦 Getting Flutter dependencies..."
flutter pub get
echo "✅ Dependencies installed"
echo ""

# Build iOS (no code sign - will sign in Xcode)
echo "🔨 Building iOS release (no code signing)..."
flutter build ios --release --no-codesign
echo "✅ Build complete"
echo ""

# Check if Xcode workspace exists
if [ ! -d "ios/Runner.xcworkspace" ]; then
    echo "❌ Error: ios/Runner.xcworkspace not found!"
    echo "   Run 'cd ios && pod install' first"
    exit 1
fi

echo "================================"
echo "✅ Build preparation complete!"
echo ""
echo "📱 Next steps:"
echo ""
echo "1. Opening Xcode workspace..."
echo "2. In Xcode:"
echo "   • Select 'Any iOS Device (arm64)' as destination"
echo "   • Go to Product → Archive"
echo "   • Wait for archive to complete"
echo "   • Click 'Distribute App'"
echo "   • Choose your distribution method:"
echo "     - App Store Connect (for TestFlight)"
echo "     - Ad Hoc (for direct distribution)"
echo ""
echo "📖 For detailed instructions, see:"
echo "   • IOS_DISTRIBUTION_GUIDE.md (distribution methods)"
echo "   • IOS_WIDGET_SETUP_GUIDE.md (widget setup)"
echo ""

# Open Xcode workspace
echo "🔧 Opening Xcode..."
open ios/Runner.xcworkspace

echo ""
echo "✨ Done! Xcode should now be open."
echo "================================"
