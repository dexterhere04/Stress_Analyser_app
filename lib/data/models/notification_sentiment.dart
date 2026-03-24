import 'package:equatable/equatable.dart';
import 'typing_metrics.dart';

class NotificationSentiment extends Equatable {
  final String id;
  final String source;
  final String preview;
  final SentimentType sentiment;
  final double score;
  final DateTime timestamp;

  const NotificationSentiment({
    required this.id,
    required this.source,
    required this.preview,
    required this.sentiment,
    required this.score,
    required this.timestamp,
  });

  double get stressImpact {
    switch (sentiment) {
      case SentimentType.positive:
        return -10.0;
      case SentimentType.neutral:
        return 0.0;
      case SentimentType.negative:
        return 15.0;
    }
  }

  @override
  List<Object?> get props => [id, source, preview, sentiment, score, timestamp];

  NotificationSentiment copyWith({
    String? id,
    String? source,
    String? preview,
    SentimentType? sentiment,
    double? score,
    DateTime? timestamp,
  }) {
    return NotificationSentiment(
      id: id ?? this.id,
      source: source ?? this.source,
      preview: preview ?? this.preview,
      sentiment: sentiment ?? this.sentiment,
      score: score ?? this.score,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
