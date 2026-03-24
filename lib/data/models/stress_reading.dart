import 'package:equatable/equatable.dart';
import 'typing_metrics.dart';
import 'notification_sentiment.dart';

class StressReading extends Equatable {
  final String id;
  final DateTime timestamp;
  final double overallScore;
  final TypingMetrics? typingMetrics;
  final List<NotificationSentiment> recentNotifications;

  const StressReading({
    required this.id,
    required this.timestamp,
    required this.overallScore,
    this.typingMetrics,
    this.recentNotifications = const [],
  });

  String get stressLabel {
    if (overallScore < 33) return 'Calm';
    if (overallScore < 66) return 'Moderate';
    return 'Stressed';
  }

  @override
  List<Object?> get props => [
    id,
    timestamp,
    overallScore,
    typingMetrics,
    recentNotifications,
  ];

  StressReading copyWith({
    String? id,
    DateTime? timestamp,
    double? overallScore,
    TypingMetrics? typingMetrics,
    List<NotificationSentiment>? recentNotifications,
  }) {
    return StressReading(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      overallScore: overallScore ?? this.overallScore,
      typingMetrics: typingMetrics ?? this.typingMetrics,
      recentNotifications: recentNotifications ?? this.recentNotifications,
    );
  }
}
