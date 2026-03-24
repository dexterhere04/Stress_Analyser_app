import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/typing_metrics.dart';
import '../../data/repositories/typing_repository.dart';
import '../../data/services/typing_service.dart';
import '../../data/services/keyboard_setup_service.dart';
import '../../providers.dart';

class TypingViewModel extends ChangeNotifier {
  final TypingRepository _repository;
  final TypingService _typingService;
  final KeyboardSetupService _keyboardService;

  bool _isSessionActive = false;
  bool _isLoading = false;
  String? _error;
  TypingMetrics? _currentMetrics;
  List<TypingMetrics> _recentSessions = [];
  List<TypingMetrics> _weeklySessions = [];

  bool _isKeyboardEnabled = false;
  bool _isKeyboardSelected = false;

  TypingViewModel(this._repository, this._typingService, this._keyboardService);

  bool get isSessionActive => _isSessionActive;
  bool get isLoading => _isLoading;
  String? get error => _error;
  TypingMetrics? get currentMetrics => _currentMetrics;
  List<TypingMetrics> get recentSessions => _recentSessions;
  List<TypingMetrics> get weeklySessions => _weeklySessions;
  bool get isKeyboardEnabled => _isKeyboardEnabled;
  bool get isKeyboardSelected => _isKeyboardSelected;
  bool get isKeyboardFullyEnabled => _isKeyboardEnabled && _isKeyboardSelected;

  double get averageStressScore {
    if (_recentSessions.isEmpty) return 0;
    return _repository.calculateAverageStressFromTyping(_recentSessions);
  }

  Future<void> loadRecentSessions() async {
    _isLoading = true;
    notifyListeners();

    try {
      _recentSessions = await _repository.getRecentSessions(limit: 20);
      _weeklySessions = await _repository.getRecentSessions(limit: 100);
      await checkKeyboardStatus();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkKeyboardStatus() async {
    _isKeyboardEnabled = await _keyboardService.isKeyboardEnabled();
    _isKeyboardSelected = await _keyboardService.isKeyboardSelected();
    notifyListeners();
  }

  void startSession() {
    _typingService.startSession();
    _isSessionActive = true;
    _currentMetrics = null;
    notifyListeners();
  }

  void recordKeystroke(String key) {
    if (_isSessionActive) {
      _typingService.recordKeystroke(key);
    }
  }

  Future<void> endSession() async {
    if (!_isSessionActive) return;

    _isLoading = true;
    notifyListeners();

    try {
      _currentMetrics = _typingService.endSession();
      if (_currentMetrics != null) {
        await _repository.saveTypingSession(_currentMetrics!);
        _recentSessions.insert(0, _currentMetrics!);
      }
      _isSessionActive = false;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void cancelSession() {
    _typingService.cancelSession();
    _isSessionActive = false;
    _currentMetrics = null;
    notifyListeners();
  }

  Future<void> enableKeyboard() async {
    await _keyboardService.enableKeyboard();
    await checkKeyboardStatus();
  }

  Future<void> disableKeyboard() async {
    await _keyboardService.disableKeyboard();
    await checkKeyboardStatus();
  }

  Future<void> openKeyboardSettings() async {
    await _keyboardService.openKeyboardSettings();
  }
}

final typingViewModelProvider = ChangeNotifierProvider<TypingViewModel>((ref) {
  final repository = ref.watch(typingRepositoryProvider);
  final typingService = ref.watch(typingServiceProvider);
  final keyboardService = KeyboardSetupService();
  return TypingViewModel(repository, typingService, keyboardService);
});
