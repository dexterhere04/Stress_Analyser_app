import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/typing_metrics.dart';
import '../services/typing_service.dart';

class TypingRepository {
  final AppDatabase _database;
  final TypingService _typingService;

  TypingRepository(this._database, this._typingService);

  TypingService get typingService => _typingService;

  Future<void> saveTypingSession(TypingMetrics metrics) async {
    await _database.insertTypingSession(
      TypingSessionsCompanion(
        id: Value(metrics.id),
        wpm: Value(metrics.wpm),
        errorRate: Value(metrics.errorRate),
        hesitationScore: Value(metrics.hesitationScore),
        rhythmVariance: Value(metrics.rhythmVariance),
        backspaceRatio: Value(metrics.backspaceRatio),
        totalKeystrokes: Value(metrics.totalKeystrokes),
        totalErrors: Value(metrics.totalErrors),
        timestamp: Value(metrics.timestamp),
        sessionDurationMs: Value(metrics.sessionDuration.inMilliseconds),
      ),
    );
  }

  Stream<List<TypingMetrics>> watchTypingSessions() {
    return _database.watchAllTypingSessions().map((sessions) {
      return sessions
          .map(
            (s) => TypingMetrics(
              id: s.id,
              wpm: s.wpm,
              errorRate: s.errorRate,
              hesitationScore: s.hesitationScore,
              rhythmVariance: s.rhythmVariance,
              backspaceRatio: s.backspaceRatio,
              totalKeystrokes: s.totalKeystrokes,
              totalErrors: s.totalErrors,
              timestamp: s.timestamp,
              sessionDuration: Duration(milliseconds: s.sessionDurationMs),
            ),
          )
          .toList();
    });
  }

  Future<List<TypingMetrics>> getRecentSessions({int limit = 10}) async {
    final sessions = await _database.getAllTypingSessions();
    return sessions
        .take(limit)
        .map(
          (s) => TypingMetrics(
            id: s.id,
            wpm: s.wpm,
            errorRate: s.errorRate,
            hesitationScore: s.hesitationScore,
            rhythmVariance: s.rhythmVariance,
            backspaceRatio: s.backspaceRatio,
            totalKeystrokes: s.totalKeystrokes,
            totalErrors: s.totalErrors,
            timestamp: s.timestamp,
            sessionDuration: Duration(milliseconds: s.sessionDurationMs),
          ),
        )
        .toList();
  }

  double calculateAverageStressFromTyping(List<TypingMetrics> sessions) {
    if (sessions.isEmpty) return 0;
    final total = sessions.fold(0.0, (sum, s) => sum + s.stressScore);
    return total / sessions.length;
  }
}
