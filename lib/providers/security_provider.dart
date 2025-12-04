import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class SecurityProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  final _localAuth = LocalAuthentication();

  bool _isAppLockEnabled = false;
  bool _isBiometricsEnabled = false;
  bool _isAuthenticated = false;

  bool get isAppLockEnabled => _isAppLockEnabled;
  bool get isBiometricsEnabled => _isBiometricsEnabled;
  bool get isAuthenticated => _isAuthenticated;

  // Keys for storage
  static const String _pinKey = 'app_pin';
  static const String _appLockEnabledKey = 'app_lock_enabled';
  static const String _biometricsEnabledKey = 'biometrics_enabled';

  Future<void> initialize() async {
    String? enabled = await _storage.read(key: _appLockEnabledKey);
    _isAppLockEnabled = enabled == 'true';

    String? bioEnabled = await _storage.read(key: _biometricsEnabledKey);
    _isBiometricsEnabled = bioEnabled == 'true';

    notifyListeners();
  }

  Future<void> setPin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
    await _storage.write(key: _appLockEnabledKey, value: 'true');
    _isAppLockEnabled = true;
    notifyListeners();
  }

  Future<bool> checkPin(String pin) async {
    String? storedPin = await _storage.read(key: _pinKey);
    return storedPin == pin;
  }

  Future<void> setBiometricsEnabled(bool enabled) async {
    await _storage.write(key: _biometricsEnabledKey, value: enabled.toString());
    _isBiometricsEnabled = enabled;
    notifyListeners();
  }

  Future<void> disableAppLock() async {
    await _storage.delete(key: _pinKey);
    await _storage.write(key: _appLockEnabledKey, value: 'false');
    _isAppLockEnabled = false;
    notifyListeners();
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      bool isDeviceSupported = await _localAuth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) {
        return false;
      }

      bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access the app',
      );
      return didAuthenticate;
    } catch (e) {
      if (kDebugMode) {
        print('Biometric authentication error: $e');
      }
      return false;
    }
  }

  DateTime? _lastPausedTime;
  static const int _autoLockTimeoutSeconds = 0; // Immediate lock

  void setLastPausedTime(DateTime? time) {
    _lastPausedTime = time;
  }

  void checkAutoLock() {
    if (_lastPausedTime != null) {
      final difference = DateTime.now().difference(_lastPausedTime!);
      if (difference.inSeconds >= _autoLockTimeoutSeconds) {
        setAuthenticated(false);
      }
      _lastPausedTime = null;
    }
  }

  void setAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  Future<bool> hasPin() async {
    String? storedPin = await _storage.read(key: _pinKey);
    return storedPin != null && storedPin.isNotEmpty;
  }
}
