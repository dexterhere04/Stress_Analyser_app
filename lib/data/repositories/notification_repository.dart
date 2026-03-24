import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';
import '../models/typing_metrics.dart';
import '../models/notification_sentiment.dart';
import '../services/sentiment_service.dart';
import '../../core/constants/app_constants.dart';

class NotificationRepository {
  final AppDatabase _database;
  final SentimentService _sentimentService;
  final _uuid = const Uuid();

  NotificationRepository(this._database, this._sentimentService);

  Future<NotificationSentiment> analyzeAndSaveNotification({
    required String source,
    required String preview,
  }) async {
    final sentiment = _sentimentService.analyze(preview);
    final score = _sentimentService.getScore(preview);
    final id = _uuid.v4();
    final timestamp = DateTime.now();

    await _database.insertNotificationRecord(
      NotificationRecordsCompanion(
        id: Value(id),
        source: Value(source),
        preview: Value(preview),
        sentiment: Value(sentiment.name),
        score: Value(score),
        timestamp: Value(timestamp),
      ),
    );

    return NotificationSentiment(
      id: id,
      source: source,
      preview: preview,
      sentiment: sentiment,
      score: score,
      timestamp: timestamp,
    );
  }

  Stream<List<NotificationSentiment>> watchNotifications() {
    return _database.watchAllNotificationRecords().map((records) {
      return records
          .map(
            (r) => NotificationSentiment(
              id: r.id,
              source: r.source,
              preview: r.preview,
              sentiment: _stringToSentimentType(r.sentiment),
              score: r.score,
              timestamp: r.timestamp,
            ),
          )
          .toList();
    });
  }

  Future<List<NotificationSentiment>> getRecentNotifications({
    int limit = 20,
    Duration within = const Duration(hours: 24),
  }) async {
    final records = await _database.getAllNotificationRecords();
    final cutoff = DateTime.now().subtract(within);

    return records
        .where((r) => r.timestamp.isAfter(cutoff))
        .take(limit)
        .map(
          (r) => NotificationSentiment(
            id: r.id,
            source: r.source,
            preview: r.preview,
            sentiment: _stringToSentimentType(r.sentiment),
            score: r.score,
            timestamp: r.timestamp,
          ),
        )
        .toList();
  }

  double calculateStressFromNotifications(
    List<NotificationSentiment> notifications,
  ) {
    if (notifications.isEmpty) return 0;

    double totalImpact = 0;
    for (final n in notifications) {
      totalImpact += n.stressImpact;
    }

    final avgImpact = totalImpact / notifications.length;
    return (50 + avgImpact).clamp(0, 100);
  }

  Map<SentimentType, int> getSentimentDistribution(
    List<NotificationSentiment> notifications,
  ) {
    final distribution = <SentimentType, int>{
      SentimentType.positive: 0,
      SentimentType.neutral: 0,
      SentimentType.negative: 0,
    };

    for (final n in notifications) {
      distribution[n.sentiment] = (distribution[n.sentiment] ?? 0) + 1;
    }

    return distribution;
  }

  Future<void> cleanupOldRecords() async {
    await _database.deleteOldRecords(AppConstants.notificationRetention);
  }

  SentimentType _stringToSentimentType(String value) {
    switch (value) {
      case 'positive':
        return SentimentType.positive;
      case 'negative':
        return SentimentType.negative;
      default:
        return SentimentType.neutral;
    }
  }
}
