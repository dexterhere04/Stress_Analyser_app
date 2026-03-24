import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart' as db;
import '../models/typing_metrics.dart';
import '../models/notification_sentiment.dart';
import '../models/stress_reading.dart';
import '../repositories/notification_repository.dart';

class StressRepository {
  final db.AppDatabase _database;
  final NotificationRepository _notificationRepository;
  final _uuid = const Uuid();

  StressRepository(this._database, this._notificationRepository);

  Future<StressReading> createStressReading({
    TypingMetrics? typingMetrics,
    List<NotificationSentiment>? recentNotifications,
  }) async {
    double score = 50.0;

    if (typingMetrics != null) {
      score = (score * 0.4) + (typingMetrics.stressScore * 0.6);
    }

    if (recentNotifications != null && recentNotifications.isNotEmpty) {
      final notificationStress = _notificationRepository
          .calculateStressFromNotifications(recentNotifications);
      score = (score * 0.7) + (notificationStress * 0.3);
    }

    score = score.clamp(0, 100);
    final id = _uuid.v4();
    final timestamp = DateTime.now();

    await _database.insertStressReading(
      db.StressReadingsCompanion(
        id: Value(id),
        timestamp: Value(timestamp),
        overallScore: Value(score),
        typingMetricsId: Value(typingMetrics?.id),
      ),
    );

    return StressReading(
      id: id,
      timestamp: timestamp,
      overallScore: score,
      typingMetrics: typingMetrics,
      recentNotifications: recentNotifications ?? [],
    );
  }

  Stream<List<StressReading>> watchStressReadings() {
    return _database.watchAllStressReadings().map((readings) {
      return readings
          .map(
            (r) => StressReading(
              id: r.id,
              timestamp: r.timestamp,
              overallScore: r.overallScore,
              typingMetrics: null,
              recentNotifications: const [],
            ),
          )
          .toList();
    });
  }

  Future<List<StressReading>> getReadingsForDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final readings = await _database.getStressReadingsForDateRange(start, end);
    return readings
        .map(
          (r) => StressReading(
            id: r.id,
            timestamp: r.timestamp,
            overallScore: r.overallScore,
            typingMetrics: null,
            recentNotifications: const [],
          ),
        )
        .toList();
  }

  Future<StressReading?> getLatestReading() async {
    final readings = await _database.getAllStressReadings();
    if (readings.isEmpty) return null;

    final latest = readings.first;
    return StressReading(
      id: latest.id,
      timestamp: latest.timestamp,
      overallScore: latest.overallScore,
      typingMetrics: null,
      recentNotifications: const [],
    );
  }

  Future<List<double>> getWeeklyTrend() async {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    final readings = await getReadingsForDateRange(weekAgo, now);

    return readings.map((r) => r.overallScore).toList();
  }

  double calculateAverageStress(List<StressReading> readings) {
    if (readings.isEmpty) return 0;
    final total = readings.fold(0.0, (sum, r) => sum + r.overallScore);
    return total / readings.length;
  }
}
