import 'package:ml_sentiment_simple/ml_sentiment_simple.dart';
import '../models/typing_metrics.dart';

class SentimentService {
  final SentimentAnalyzer _analyzer = SentimentAnalyzer();

  SentimentType analyze(String text) {
  if (text.trim().isEmpty) return SentimentType.neutral;

  final lower = text.toLowerCase();

  const strongNegative = [
    'depress',
    'suicid',
    'kill myself',
    'want to die',
    'end my life'
  ];

  for (final word in strongNegative) {
    if (lower.contains(word)) {
      return SentimentType.negative;
    }
  }


  final result = _analyzer.analyze(text);

  if (result.score < -0.2) return SentimentType.negative;
  if (result.score > 0.2) return SentimentType.positive;

  return SentimentType.neutral;
}
