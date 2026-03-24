class AppConstants {
  static const String appName = 'DeStresser';
  static const String appVersion = '1.0.0';

  static const int stressScoreMin = 0;
  static const int stressScoreMax = 100;

  static const double calmThreshold = 33.0;
  static const double moderateThreshold = 66.0;

  static const int typingSessionDurationSeconds = 60;
  static const int keystrokeSampleSize = 100;

  static const Duration analysisInterval = Duration(minutes: 15);
  static const Duration notificationRetention = Duration(days: 7);
}
