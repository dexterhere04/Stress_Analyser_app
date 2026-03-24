import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/notification_sentiment.dart';
import '../../data/models/typing_metrics.dart';
import '../../data/repositories/notification_repository.dart';
import '../../data/services/notification_listener_service.dart';
import '../../providers.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotificationRepository _repository;
  final NotificationListenerService _listenerService;

  bool _isLoading = false;
  String? _error;
  List<NotificationSentiment> _recentNotifications = [];
  Map<SentimentType, int> _sentimentDistribution = {};
  bool _isAutoListening = false;
  bool _hasPermission = false;
  bool _pendingAutoStartAfterPermission = false;

  NotificationViewModel(this._repository, this._listenerService) {
    _listenerService.onNotificationAnalyzed = _onNotificationAnalyzed;
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<NotificationSentiment> get recentNotifications => _recentNotifications;
  Map<SentimentType, int> get sentimentDistribution => _sentimentDistribution;
  bool get isAutoListening => _isAutoListening;
  bool get hasPermission => _hasPermission;

  double get stressScore {
    if (_recentNotifications.isEmpty) return 0;
    return _repository.calculateStressFromNotifications(_recentNotifications);
  }

  int get totalCount => _recentNotifications.length;

  int get positiveCount => _sentimentDistribution[SentimentType.positive] ?? 0;
  int get neutralCount => _sentimentDistribution[SentimentType.neutral] ?? 0;
  int get negativeCount => _sentimentDistribution[SentimentType.negative] ?? 0;

  Future<void> loadRecentNotifications() async {
    _isLoading = true;
    notifyListeners();

    try {
      _recentNotifications = await _repository.getRecentNotifications(
        limit: 50,
        within: const Duration(hours: 24),
      );
      _sentimentDistribution = _repository.getSentimentDistribution(
        _recentNotifications,
      );
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkPermission() async {
    _hasPermission = await _listenerService.checkPermission();
    notifyListeners();
  }

  Future<bool> requestPermission() async {
    _hasPermission = await _listenerService.requestPermission();

    if (_hasPermission && _pendingAutoStartAfterPermission && !_isAutoListening) {
      await _listenerService.startListening();
      _isAutoListening = _listenerService.isListening;
      if (_isAutoListening) {
        _pendingAutoStartAfterPermission = false;
      }
    }

    notifyListeners();
    return _hasPermission;
  }

  Future<void> openNotificationSettings() async {
    await _listenerService.requestPermission();
  }

  Future<void> startAutoListening() async {
    if (_isAutoListening) return;

    _hasPermission = await _listenerService.checkPermission();
    if (!_hasPermission) {
      _pendingAutoStartAfterPermission = true;
      await _listenerService.requestPermission();
      notifyListeners();
      return;
    }

    await _listenerService.startListening();
    _isAutoListening = _listenerService.isListening;
    if (_isAutoListening) {
      _pendingAutoStartAfterPermission = false;
    }
    notifyListeners();
  }

  Future<void> stopAutoListening() async {
    if (!_isAutoListening) return;

    await _listenerService.stopListening();
    _isAutoListening = false;
    _pendingAutoStartAfterPermission = false;
    notifyListeners();
  }

  Future<void> onAppResumed() async {
    final previousPermission = _hasPermission;
    _hasPermission = await _listenerService.checkPermission();

    if (_hasPermission && _pendingAutoStartAfterPermission && !_isAutoListening) {
      await _listenerService.startListening();
      _isAutoListening = _listenerService.isListening;
      if (_isAutoListening) {
        _pendingAutoStartAfterPermission = false;
      }
    }

    if (!_hasPermission && previousPermission && _isAutoListening) {
      _isAutoListening = false;
    }

    notifyListeners();
  }

  void _onNotificationAnalyzed(NotificationSentiment notification) {
    _recentNotifications.insert(0, notification);
    _sentimentDistribution = _repository.getSentimentDistribution(
      _recentNotifications,
    );
    notifyListeners();
  }

  Future<void> addNotification({
    required String source,
    required String preview,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final notification = await _repository.analyzeAndSaveNotification(
        source: source,
        preview: preview,
      );
      _recentNotifications.insert(0, notification);
      _sentimentDistribution = _repository.getSentimentDistribution(
        _recentNotifications,
      );
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cleanup() async {
    await _repository.cleanupOldRecords();
    await loadRecentNotifications();
  }

  @override
  void dispose() {
    _listenerService.dispose();
    super.dispose();
  }
}

final notificationViewModelProvider =
    ChangeNotifierProvider<NotificationViewModel>((ref) {
      final repository = ref.watch(notificationRepositoryProvider);
      final listenerService = ref.watch(notificationListenerServiceProvider);
      return NotificationViewModel(repository, listenerService);
    });
