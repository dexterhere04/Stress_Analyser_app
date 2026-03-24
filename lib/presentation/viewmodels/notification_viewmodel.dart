import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/typing_metrics.dart';
import '../../data/models/notification_sentiment.dart';
import '../../data/repositories/notification_repository.dart';
import '../../providers.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotificationRepository _repository;

  bool _isLoading = false;
  String? _error;
  List<NotificationSentiment> _recentNotifications = [];
  Map<SentimentType, int> _sentimentDistribution = {};

  NotificationViewModel(this._repository);

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<NotificationSentiment> get recentNotifications => _recentNotifications;
  Map<SentimentType, int> get sentimentDistribution => _sentimentDistribution;

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
}

final notificationViewModelProvider =
    ChangeNotifierProvider<NotificationViewModel>((ref) {
      final repository = ref.watch(notificationRepositoryProvider);
      return NotificationViewModel(repository);
    });
