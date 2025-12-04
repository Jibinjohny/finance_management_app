import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/security_provider.dart';
import '../utils/app_colors.dart';
import '../utils/glass_snackbar.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class AppLockScreen extends StatefulWidget {
  final bool isSettingPin;
  final Function(String)? onPinSet;
  final VoidCallback? onSuccess;

  const AppLockScreen({
    super.key,
    this.isSettingPin = false,
    this.onPinSet,
    this.onSuccess,
  });

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen>
    with SingleTickerProviderStateMixin {
  String _enteredPin = '';
  String _confirmPin = '';
  bool _isConfirming = false;
  bool _isUnlocked = false;
  late AnimationController _shakeController;
  late Animation<Offset> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.1, 0.0)).animate(
          CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
        );

    if (!widget.isSettingPin) {
      _checkBiometrics();
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> _checkBiometrics() async {
    final securityProvider = Provider.of<SecurityProvider>(
      context,
      listen: false,
    );
    if (securityProvider.isBiometricsEnabled) {
      bool authenticated = await securityProvider.authenticateWithBiometrics();
      if (authenticated && mounted) {
        _handleSuccess();
      }
    }
  }

  void _onDigitPressed(String digit) {
    if (_isUnlocked) return;
    setState(() {
      if (_enteredPin.length < 4) {
        _enteredPin += digit;
        if (_enteredPin.length == 4) {
          _handlePinComplete();
        }
      }
    });
  }

  void _onDeletePressed() {
    if (_isUnlocked) return;
    setState(() {
      if (_enteredPin.isNotEmpty) {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      }
    });
  }

  void _handleSuccess() async {
    setState(() {
      _isUnlocked = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      if (widget.onSuccess != null) {
        widget.onSuccess!();
      } else {
        Provider.of<SecurityProvider>(
          context,
          listen: false,
        ).setAuthenticated(true);
      }
    }
  }

  void _handlePinComplete() async {
    if (widget.isSettingPin) {
      if (!_isConfirming) {
        setState(() {
          _confirmPin = _enteredPin;
          _enteredPin = '';
          _isConfirming = true;
        });
      } else {
        if (_enteredPin == _confirmPin) {
          widget.onPinSet?.call(_enteredPin);
        } else {
          _shakeController.forward().then((_) => _shakeController.reverse());
          GlassSnackBar.showError(context, message: 'PINs do not match');
          setState(() {
            _enteredPin = '';
            _confirmPin = '';
            _isConfirming = false;
          });
        }
      }
    } else {
      final securityProvider = Provider.of<SecurityProvider>(
        context,
        listen: false,
      );
      bool isValid = await securityProvider.checkPin(_enteredPin);
      if (isValid) {
        _handleSuccess();
      } else {
        if (mounted) {
          _shakeController.forward().then((_) => _shakeController.reverse());
          GlassSnackBar.showError(context, message: 'Incorrect PIN');
          setState(() {
            _enteredPin = '';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                  Color(0xFF0F3460),
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                ],
              ),
            ),
          ),
          // Background Blobs
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.isSettingPin)
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 60),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                  child: Icon(
                    _isUnlocked ? Icons.lock_open_rounded : Icons.lock_outline,
                    key: ValueKey<bool>(_isUnlocked),
                    size: 40,
                    color: _isUnlocked ? AppColors.success : Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.isSettingPin
                      ? (_isConfirming ? 'Confirm PIN' : 'Set PIN')
                      : 'Enter PIN',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 40),
                SlideTransition(
                  position: _shakeAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index < _enteredPin.length
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.2),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      );
                    }),
                  ),
                ),
                const Spacer(),
                _buildNumberPad(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberPad() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          _buildRow(['1', '2', '3']),
          const SizedBox(height: 24),
          _buildRow(['4', '5', '6']),
          const SizedBox(height: 24),
          _buildRow(['7', '8', '9']),
          const SizedBox(height: 24),
          _buildRow(['biometric', '0', 'delete']),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items.map((item) {
        if (item == 'biometric') {
          return _buildBiometricButton();
        } else if (item == 'delete') {
          return _buildDeleteButton();
        } else {
          return _buildDigitButton(item);
        }
      }).toList(),
    );
  }

  Widget _buildDigitButton(String digit) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _onDigitPressed(digit),
            customBorder: const CircleBorder(),
            splashColor: Colors.white24,
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.15),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  digit,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _onDeletePressed,
        customBorder: const CircleBorder(),
        splashColor: Colors.white24,
        child: Container(
          width: 75,
          height: 75,
          alignment: Alignment.center,
          child: const Text(
            'Delete',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBiometricButton() {
    if (widget.isSettingPin) return const SizedBox(width: 75, height: 75);

    return Consumer<SecurityProvider>(
      builder: (context, provider, child) {
        if (!provider.isBiometricsEnabled) {
          return const SizedBox(width: 75, height: 75);
        }
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _checkBiometrics,
            customBorder: const CircleBorder(),
            splashColor: Colors.white24,
            child: Container(
              width: 75,
              height: 75,
              alignment: Alignment.center,
              child: const Icon(
                Icons
                    .face, // Or fingerprint based on platform, but generic for now
                color: Colors.white70,
                size: 32,
              ),
            ),
          ),
        );
      },
    );
  }
}
