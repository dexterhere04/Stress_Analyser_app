import 'package:ml_sentiment_simple/ml_sentiment_simple.dart';
import '../models/typing_metrics.dart';

class SentimentService {
  final SentimentAnalyzer _analyzer = SentimentAnalyzer();

  SentimentType analyze(String text) {
    if (text.trim().isEmpty) {
      return SentimentType.neutral;
    }

    final result = _analyzer.analyze(text);

    if (result.label == 'positive') {
      return SentimentType.positive;
    } else if (result.label == 'negative') {
      return SentimentType.negative;
    } else {
      return SentimentType.neutral;
    }
  }

  double getScore(String text) {
    if (text.trim().isEmpty) {
      return 0.0;
    }
    return _analyzer.analyze(text).score;
  }
}
