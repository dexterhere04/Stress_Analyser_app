import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/notification_sentiment.dart';
import '../repositories/notification_repository.dart';
import 'sentiment_service.dart';

class NotificationListenerService {
  static const MethodChannel _channel = MethodChannel(
    'com.destresser/notification_listener',
  );
  static const EventChannel _eventChannel = EventChannel(
    'com.destresser/notifications',
  );

  final SentimentService _sentimentService;
  final NotificationRepository _repository;

  StreamSubscription? _subscription;
  bool _isListening = false;
  bool _hasPermission = false;

  Function(NotificationSentiment)? onNotificationAnalyzed;

  NotificationListenerService(this._sentimentService, this._repository);

  bool get isListening => _isListening;
  bool get hasPermission => _hasPermission;

  Future<bool> checkPermission() async {
    try {
      final result = await _channel.invokeMethod<bool>('checkPermission');
      _hasPermission = result ?? false;
      return _hasPermission;
    } on PlatformException catch (e) {
      debugPrint('Error checking notification permission: ${e.message}');
      _hasPermission = false;
      return false;
    }
  }

  Future<bool> requestPermission() async {
    try {
      final result = await _channel.invokeMethod<bool>('requestPermission');
      _hasPermission = result ?? false;
      return _hasPermission;
    } on PlatformException catch (e) {
      debugPrint('Error requesting notification permission: ${e.message}');
      _hasPermission = false;
      return false;
    }
  }

  Future<void> startListening() async {
    if (_isListening) return;

    final hasAccess = await checkPermission();
    if (!hasAccess) {
      debugPrint('Notification listener permission not granted');
      return;
    }

    try {
      await _channel.invokeMethod('startListening');
      _isListening = true;

      _subscription = _eventChannel.receiveBroadcastStream().listen(
        (event) {
          if (event is Map) {
            final appName = event['appName'] as String? ?? 'Unknown';
            final text = event['text'] as String? ?? '';

            if (text.isNotEmpty) {
              _analyzeAndSave(appName, text);
            }
          }
        },
        onError: (error) {
          debugPrint('Notification stream error: $error');
          _isListening = false;
        },
      );
    } on PlatformException catch (e) {
      debugPrint('Error starting notification listener: ${e.message}');
      _isListening = false;
    }
  }

  Future<void> stopListening() async {
    if (!_isListening) return;

    try {
      await _channel.invokeMethod('stopListening');
      _subscription?.cancel();
      _subscription = null;
      _isListening = false;
    } on PlatformException catch (e) {
      debugPrint('Error stopping notification listener: ${e.message}');
    }
  }

  Future<void> _analyzeAndSave(String appName, String text) async {
    _sentimentService.analyze(text);
    _sentimentService.getScore(text);

    final notification = await _repository.analyzeAndSaveNotification(
      source: appName,
      preview: text,
    );

    onNotificationAnalyzed?.call(notification);
  }

  void dispose() {
    stopListening();
  }
}
