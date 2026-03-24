import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/stress_reading.dart';
import '../../data/models/typing_metrics.dart';
import '../../data/models/notification_sentiment.dart';
import '../../data/repositories/stress_repository.dart';
import '../../providers.dart';

class DashboardViewModel extends ChangeNotifier {
  final StressRepository _repository;

  bool _isLoading = false;
  String? _error;
  StressReading? _latestReading;
  List<StressReading> _recentReadings = [];
  List<double> _weeklyTrend = [];
  double _averageStress = 0;

  DashboardViewModel(this._repository);

  bool get isLoading => _isLoading;
  String? get error => _error;
  StressReading? get latestReading => _latestReading;
  List<StressReading> get recentReadings => _recentReadings;
  List<double> get weeklyTrend => _weeklyTrend;
  double get averageStress => _averageStress;

  double get currentStressScore => _latestReading?.overallScore ?? 50.0;
  String get stressLabel => _latestReading?.stressLabel ?? 'Unknown';

  Future<void> loadDashboardData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _latestReading = await _repository.getLatestReading();
      _weeklyTrend = await _repository.getWeeklyTrend();

      final now = DateTime.now();
      final weekAgo = now.subtract(const Duration(days: 7));
      _recentReadings = await _repository.getReadingsForDateRange(weekAgo, now);
      _averageStress = _repository.calculateAverageStress(_recentReadings);

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> recordStressReading({
    TypingMetrics? typingMetrics,
    List<NotificationSentiment>? notifications,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      _latestReading = await _repository.createStressReading(
        typingMetrics: typingMetrics,
        recentNotifications: notifications,
      );
      _recentReadings.insert(0, _latestReading!);
      _weeklyTrend.add(_latestReading!.overallScore);
      _averageStress = _repository.calculateAverageStress(_recentReadings);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

final dashboardViewModelProvider = ChangeNotifierProvider<DashboardViewModel>((
  ref,
) {
  final repository = ref.watch(stressRepositoryProvider);
  return DashboardViewModel(repository);
});
