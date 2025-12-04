import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/security_provider.dart';
import '../utils/app_colors.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/glass_container.dart';
import 'app_lock_screen.dart';

class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Security',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
            child: Consumer<SecurityProvider>(
              builder: (context, security, child) {
                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    GlassContainer(
                      padding: const EdgeInsets.all(16),
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        children: [
                          SwitchListTile(
                            title: const Text(
                              'App Lock',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: const Text(
                              'Protect app with PIN',
                              style: TextStyle(color: Colors.white60),
                            ),
                            value: security.isAppLockEnabled,
                            activeTrackColor: AppColors.primary,
                            onChanged: (value) {
                              if (value) {
                                _setupPin(context);
                              } else {
                                _disableAppLock(context);
                              }
                            },
                          ),
                          if (security.isAppLockEnabled) ...[
                            const Divider(color: Colors.white10),
                            SwitchListTile(
                              title: const Text(
                                'Biometrics',
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: const Text(
                                'Use FaceID or Fingerprint',
                                style: TextStyle(color: Colors.white60),
                              ),
                              value: security.isBiometricsEnabled,
                              activeTrackColor: AppColors.primary,
                              onChanged: (value) {
                                security.setBiometricsEnabled(value);
                              },
                            ),
                            const Divider(color: Colors.white10),
                            ListTile(
                              title: const Text(
                                'Change PIN',
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: const Icon(
                                Icons.chevron_right,
                                color: Colors.white54,
                              ),
                              onTap: () => _changePin(context),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _setupPin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AppLockScreen(
          isSettingPin: true,
          onPinSet: (pin) {
            Provider.of<SecurityProvider>(context, listen: false).setPin(pin);
            Navigator.of(context).pop();
            GlassSnackBar.showSuccess(context, message: 'App Lock Enabled');
          },
        ),
      ),
    );
  }

  void _disableAppLock(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AppLockScreen(
          isSettingPin: false,
          onSuccess: () {
            Provider.of<SecurityProvider>(
              context,
              listen: false,
            ).disableAppLock();
            Navigator.of(context).pop();
            GlassSnackBar.showSuccess(context, message: 'App Lock Disabled');
          },
        ),
      ),
    );
  }

  void _changePin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AppLockScreen(
          isSettingPin: true,
          onPinSet: (pin) {
            Provider.of<SecurityProvider>(context, listen: false).setPin(pin);
            Navigator.of(context).pop();
            GlassSnackBar.showSuccess(context, message: 'PIN Updated');
          },
        ),
      ),
    );
  }
}
