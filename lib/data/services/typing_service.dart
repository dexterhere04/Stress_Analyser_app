import 'package:uuid/uuid.dart';
import '../models/typing_metrics.dart';

class KeystrokeData {
  final String key;
  final DateTime timestamp;
  final bool isBackspace;

  KeystrokeData({
    required this.key,
    required this.timestamp,
    required this.isBackspace,
  });
}

class TypingService {
  final _uuid = const Uuid();
  final List<KeystrokeData> _keystrokes = [];
  final List<int> _interKeyDurations = [];
  DateTime? _sessionStart;
  DateTime? _lastKeystrokeTime;

  bool get isSessionActive => _sessionStart != null;

  void startSession() {
    _keystrokes.clear();
    _interKeyDurations.clear();
    _sessionStart = DateTime.now();
    _lastKeystrokeTime = null;
  }

  void recordKeystroke(String key) {
    if (_sessionStart == null) return;

    final now = DateTime.now();
    final isBackspace = key == 'Backspace';

    _keystrokes.add(
      KeystrokeData(key: key, timestamp: now, isBackspace: isBackspace),
    );

    if (_lastKeystrokeTime != null) {
      final duration = now.difference(_lastKeystrokeTime!).inMilliseconds;
      if (duration < 5000) {
        _interKeyDurations.add(duration);
      }
    }

    _lastKeystrokeTime = now;
  }

  TypingMetrics? endSession() {
    if (_sessionStart == null || _keystrokes.isEmpty) return null;

    final sessionEnd = DateTime.now();
    final sessionDuration = sessionEnd.difference(_sessionStart!);

    final totalKeystrokes = _keystrokes.where((k) => !k.isBackspace).length;
    final totalBackspaces = _keystrokes.where((k) => k.isBackspace).length;
    final totalErrors = _keystrokes.where((k) => k.isBackspace).length;

    final wpm = _calculateWPM(totalKeystrokes, sessionDuration);
    final errorRate = totalKeystrokes > 0
        ? (totalErrors / totalKeystrokes) * 100
        : 0.0;
    final hesitationScore = _calculateHesitationScore();
    final rhythmVariance = _calculateRhythmVariance();
    final backspaceRatio = totalKeystrokes > 0
        ? totalBackspaces / totalKeystrokes
        : 0.0;

    _sessionStart = null;
    _lastKeystrokeTime = null;

    return TypingMetrics(
      id: _uuid.v4(),
      wpm: wpm,
      errorRate: errorRate,
      hesitationScore: hesitationScore,
      rhythmVariance: rhythmVariance,
      backspaceRatio: backspaceRatio,
      totalKeystrokes: totalKeystrokes,
      totalErrors: totalErrors,
      timestamp: sessionEnd,
      sessionDuration: sessionDuration,
    );
  }

  double _calculateWPM(int keystrokes, Duration duration) {
    if (duration.inSeconds == 0) return 0;
    final minutes = duration.inSeconds / 60.0;
    final words = keystrokes / 5.0;
    return words / minutes;
  }

  double _calculateHesitationScore() {
    if (_interKeyDurations.isEmpty) return 0;

    final longPauses = _interKeyDurations.where((d) => d > 500).length;
    return _interKeyDurations.isNotEmpty
        ? (longPauses / _interKeyDurations.length).clamp(0.0, 1.0)
        : 0.0;
  }

  double _calculateRhythmVariance() {
    if (_interKeyDurations.length < 3) return 0;

    final mean =
        _interKeyDurations.reduce((a, b) => a + b) / _interKeyDurations.length;
    final variance =
        _interKeyDurations
            .map((d) => (d - mean) * (d - mean))
            .reduce((a, b) => a + b) /
        _interKeyDurations.length;

    final normalizedVariance = (variance / (mean * mean)).clamp(0.0, 1.0);
    return normalizedVariance;
  }

  void cancelSession() {
    _sessionStart = null;
    _lastKeystrokeTime = null;
    _keystrokes.clear();
    _interKeyDurations.clear();
  }
}
