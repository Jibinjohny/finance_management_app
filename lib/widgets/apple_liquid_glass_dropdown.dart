import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'glass_container.dart';

class AppleLiquidGlassDropdownItem<T> {
  final T value;
  final String label;

  const AppleLiquidGlassDropdownItem({
    required this.value,
    required this.label,
  });
}

class AppleLiquidGlassDropdown<T> extends StatefulWidget {
  final T? value;
  final String hint;
  final List<AppleLiquidGlassDropdownItem<T>> items;
  final ValueChanged<T?> onChanged;
  final double? width;

  const AppleLiquidGlassDropdown({
    super.key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.width,
  });

  @override
  State<AppleLiquidGlassDropdown<T>> createState() => _AppleLiquidGlassDropdownState<T>();
}

class _AppleLiquidGlassDropdownState<T> extends State<AppleLiquidGlassDropdown<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _springController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _springController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnimation = _springController;
  }

  @override
  void dispose() {
    _springController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _springController.animateTo(0.95, curve: Curves.easeOutCubic);
  }

  void _handleTapUp(TapUpDetails details) {
    _springController.animateTo(1.0, curve: Curves.elasticOut);
  }

  void _handleTapCancel() {
    _springController.animateTo(1.0, curve: Curves.easeOutCubic);
  }

  void _showGlassMenu(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: _AppleLiquidGlassMenuDialog<T>(
            items: widget.items,
            selectedValue: widget.value,
            onSelected: (val) {
              widget.onChanged(val);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem = widget.items.cast<AppleLiquidGlassDropdownItem<T>?>().firstWhere(
          (item) => item?.value == widget.value,
          orElse: () => null,
        );

    final displayLabel = selectedItem?.label ?? widget.hint;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: () => _showGlassMenu(context),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: GlassContainer(
            width: widget.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withValues(alpha: _isHovered ? 0.12 : 0.08),
            borderColor: Colors.white.withValues(alpha: _isHovered ? 0.22 : 0.15),
            borderWidth: 1.0,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: _isHovered ? 0.25 : 0.15),
                blurRadius: _isHovered ? 12 : 8,
                spreadRadius: -2,
                offset: const Offset(0, 4),
              ),
            ],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    displayLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white70,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppleLiquidGlassMenuDialog<T> extends StatefulWidget {
  final List<AppleLiquidGlassDropdownItem<T>> items;
  final T? selectedValue;
  final ValueChanged<T?> onSelected;

  const _AppleLiquidGlassMenuDialog({
    required this.items,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  State<_AppleLiquidGlassMenuDialog<T>> createState() => _AppleLiquidGlassMenuDialogState<T>();
}

class _AppleLiquidGlassMenuDialogState<T> extends State<_AppleLiquidGlassMenuDialog<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.elasticOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOut,
      ),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            child: Material(
              color: Colors.transparent,
              child: GlassContainer(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withValues(alpha: 0.4),
                borderColor: Colors.white.withValues(alpha: 0.18),
                borderWidth: 1.2,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                    offset: const Offset(0, 10),
                  ),
                ],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(widget.items.length, (index) {
                    final item = widget.items[index];
                    final isSelected = item.value == widget.selectedValue;

                    return _AppleLiquidGlassMenuItemWidget(
                      label: item.label,
                      isSelected: isSelected,
                      isFirst: index == 0,
                      isLast: index == widget.items.length - 1,
                      onTap: () => widget.onSelected(item.value),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppleLiquidGlassMenuItemWidget extends StatefulWidget {
  final String label;
  final bool isSelected;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  const _AppleLiquidGlassMenuItemWidget({
    required this.label,
    required this.isSelected,
    required this.isFirst,
    required this.isLast,
    required this.onTap,
  });

  @override
  State<_AppleLiquidGlassMenuItemWidget> createState() => _AppleLiquidGlassMenuItemWidgetState();
}

class _AppleLiquidGlassMenuItemWidgetState extends State<_AppleLiquidGlassMenuItemWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
          border: widget.isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: Colors.white.withValues(alpha: 0.08),
                    width: 1.0,
                  ),
                ),
        ),
        child: Row(
          children: [
            // Checkmark indicator (just like iOS native context menu)
            SizedBox(
              width: 24,
              child: widget.isSelected
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 18,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: widget.isSelected ? Colors.white : Colors.white70,
                  fontSize: 16,
                  fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
