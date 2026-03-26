SentimentType analyze(String text) {
  if (text.trim().isEmpty) {
    return SentimentType.neutral;
  }

  final lower = text.toLowerCase();

  const negativeKeywords = [
    'depressed',
    'sad',
    'lonely',
    'empty',
    'tired of life',
    'hate myself',
    'want to die',
    'kill myself',
    'suicidal'
  ];

  for (final word in negativeKeywords) {
    if (lower.contains(word)) {
      return SentimentType.negative;
    }
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
