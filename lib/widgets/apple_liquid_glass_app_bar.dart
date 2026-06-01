import 'package:flutter/material.dart';
import 'apple_liquid_glass_icon_button.dart';

class AppleLiquidGlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic title;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool showBackButton;

  const AppleLiquidGlassAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onBackPressed,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false, // Turn off default back button
      leadingWidth: 72,
      leading: showBackButton
          ? Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: AppleLiquidGlassIconButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  padding: EdgeInsets.zero,
                  onPressed: onBackPressed ?? () => Navigator.pop(context),
                ),
              ),
            )
          : null,
      title: title is Widget
          ? title
          : Text(
              title.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
      actions: actions != null
          ? actions!.map((action) {
              return Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: action,
                ),
              );
            }).toList()
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
