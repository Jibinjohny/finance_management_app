---
name: platform-ui-design
description: Complete design system instructions for platform-adaptive interfaces in CashFlow, detailing iOS Liquid Glass (glassmorphic styling, blurs, glow shadows) and Android Native (Material 3, edge-to-edge screens, ripple touch dynamics).
---

# Platform-Adaptive UI/UX Design Guidelines

This skill defines the styling principles, aesthetic specifications, and reusable code implementations for transforming CashFlow into a premium visual experience.

---

## 1. Dynamic Platform Detection

To dynamically load platform styles, avoid querying raw hardcoded features. Instead, inspect the runtime target platform or verify active context properties:

```dart
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

bool isIOSPlatform(BuildContext context) {
  if (kIsWeb) return false;
  return Theme.of(context).platform == TargetPlatform.iOS || 
         Theme.of(context).platform == TargetPlatform.macOS;
}
```

---

## 2. iOS "Liquid Glass" Aesthetic (Glassmorphism)

The iOS interface must look premium, modern, and fluid. It leverages deep frosted-glass layers, organic radial glows, thin reflective borders, and modern typography.

### Design Tokens
*   **Fonts**: `GoogleFonts.outfit()` (Primary headers) or `GoogleFonts.inter()` (Content body).
*   **Core Blur**: `ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0)` for primary container backdrops.
*   **Opacity Standard**: Base container white opacity range between `0.05` and `0.15` depending on layering depth.
*   **Borders**: `1.0px` solid line using `Colors.white.withOpacity(0.18)` or matching accent glow overlays.
*   **Color Theme**: Sleek dark slate base (`#0F1016`) blended with vibrant, tailored neon gradients (Emerald, Royal Cyan, Neon Violet).

### Reusable Liquid Glass Container Snippet
Use this core design layout when building cards, headers, and dashboard widgets on iOS:

```dart
import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidGlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final List<Color>? borderGradientColors;

  const LiquidGlassCard({
    super.key,
    required this.child,
    this.borderRadius = 24.0,
    this.borderGradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 30.0,
                spreadRadius: -10.0,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
```

---

## 3. Android Native Material 3 Design

For Android, focus on Google’s official **Material Design 3 (M3)** specifications, highlighting fluid edge-to-edge screens, organic dynamic coloring, tactile ripples, and structural navigation sheets.

### Design Tokens
*   **Fonts**: `GoogleFonts.roboto()` or `GoogleFonts.lexend()`.
*   **Feedback**: Always use physical-like feedback such as `HapticFeedback.lightImpact()` on tap actions.
*   **Ripples**: Use bounded or unbounded `InkWell` containers with matching primary theme container splash overlays:
    ```dart
    splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
    ```
*   **Sheets & Panels**: Rounded sheets utilizing `BorderRadius.vertical(top: Radius.circular(28.0))` and matching navigation indicators.

### Reusable Android Bottom Sheet Snippet
Use this clean M3 dialog standard on Android devices:

```dart
import 'package:flutter/material.dart';

void showAndroidNativeSheet(BuildContext context, Widget content) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
    ),
    elevation: 4.0,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      );
    },
  );
}
```

---

## 4. Interaction & Motion Rules

1.  **Micro-animations**: Integrate subtle enter motions with the `animate_do` library (e.g., `FadeInUp(duration: Duration(milliseconds: 400), child: ...)`). Avoid using slow, distracting, or heavy layouts.
2.  **Scroll Parallax**: Provide high-fidelity, scroll-driven interactions in statistics and insights tabs.
3.  **Adaptive Toggle**: Always wire high-level layout hubs (`dashboard_screen.dart`, `insights_screen.dart`) to inspect platform type and load corresponding layout structures dynamically, ensuring native excellence on both ecosystems.
