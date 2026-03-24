import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyboardSetupService {
  static const _channel = MethodChannel('com.destresser/keyboard');
  static const _prefsKey = 'destresser_keyboard_enabled';

  static const String imeId = 'com.example.destresser/.ime.FlorisImeService';

  Future<bool> isKeyboardEnabled() async {
    try {
      final result = await _channel.invokeMethod<bool>('isKeyboardEnabled');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> isKeyboardSelected() async {
    try {
      final result = await _channel.invokeMethod<bool>('isKeyboardSelected');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> isKeyboardFullyEnabled() async {
    final enabled = await isKeyboardEnabled();
    final selected = await isKeyboardSelected();
    return enabled && selected;
  }

  Future<void> enableKeyboard() async {
    try {
      await _channel.invokeMethod('enableKeyboard');
      await _saveEnabledState(true);
    } on PlatformException catch (e) {
      debugPrint('Failed to enable keyboard: ${e.message}');
    }
  }

  Future<void> disableKeyboard() async {
    try {
      await _channel.invokeMethod('disableKeyboard');
      await _saveEnabledState(false);
    } on PlatformException catch (e) {
      debugPrint('Failed to disable keyboard: ${e.message}');
    }
  }

  Future<void> openKeyboardSettings() async {
    try {
      await _channel.invokeMethod('openKeyboardSettings');
    } on PlatformException catch (e) {
      debugPrint('Failed to open keyboard settings: ${e.message}');
    }
  }

  Future<bool> getEnabledState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefsKey) ?? false;
  }

  Future<void> _saveEnabledState(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, enabled);
  }

  Future<Map<String, dynamic>> getLastSessionMetrics() async {
    try {
      final result = await _channel.invokeMethod<Map>('getLastSessionMetrics');
      if (result == null) return {};
      return Map<String, dynamic>.from(result);
    } on PlatformException {
      return {};
    }
  }

  Future<bool> hasPendingSession() async {
    try {
      final result = await _channel.invokeMethod<bool>('hasPendingSession');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  Future<void> clearSession() async {
    try {
      await _channel.invokeMethod('clearSession');
    } on PlatformException catch (e) {
      debugPrint('Failed to clear session: ${e.message}');
    }
  }
}
