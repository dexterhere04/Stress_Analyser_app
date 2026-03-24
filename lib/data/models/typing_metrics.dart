import 'package:equatable/equatable.dart';

enum SentimentType { positive, neutral, negative }

class TypingMetrics extends Equatable {
  final String id;
  final double wpm;
  final double errorRate;
  final double hesitationScore;
  final double rhythmVariance;
  final double backspaceRatio;
  final int totalKeystrokes;
  final int totalErrors;
  final DateTime timestamp;
  final Duration sessionDuration;

  const TypingMetrics({
    required this.id,
    required this.wpm,
    required this.errorRate,
    required this.hesitationScore,
    required this.rhythmVariance,
    required this.backspaceRatio,
    required this.totalKeystrokes,
    required this.totalErrors,
    required this.timestamp,
    required this.sessionDuration,
  });

  double get stressScore {
    double score = 0;
    score += errorRate * 25;
    score += hesitationScore * 25;
    score += rhythmVariance * 20;
    score += backspaceRatio * 30;
    return score.clamp(0, 100);
  }

  @override
  List<Object?> get props => [
    id,
    wpm,
    errorRate,
    hesitationScore,
    rhythmVariance,
    backspaceRatio,
    totalKeystrokes,
    totalErrors,
    timestamp,
    sessionDuration,
  ];

  TypingMetrics copyWith({
    String? id,
    double? wpm,
    double? errorRate,
    double? hesitationScore,
    double? rhythmVariance,
    double? backspaceRatio,
    int? totalKeystrokes,
    int? totalErrors,
    DateTime? timestamp,
    Duration? sessionDuration,
  }) {
    return TypingMetrics(
      id: id ?? this.id,
      wpm: wpm ?? this.wpm,
      errorRate: errorRate ?? this.errorRate,
      hesitationScore: hesitationScore ?? this.hesitationScore,
      rhythmVariance: rhythmVariance ?? this.rhythmVariance,
      backspaceRatio: backspaceRatio ?? this.backspaceRatio,
      totalKeystrokes: totalKeystrokes ?? this.totalKeystrokes,
      totalErrors: totalErrors ?? this.totalErrors,
      timestamp: timestamp ?? this.timestamp,
      sessionDuration: sessionDuration ?? this.sessionDuration,
    );
  }
}
