import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/app_database.dart';
import '../data/services/typing_service.dart';
import '../data/services/sentiment_service.dart';
import '../data/repositories/typing_repository.dart';
import '../data/repositories/notification_repository.dart';
import '../data/repositories/stress_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final typingServiceProvider = Provider<TypingService>((ref) {
  return TypingService();
});

final sentimentServiceProvider = Provider<SentimentService>((ref) {
  return SentimentService();
});

final typingRepositoryProvider = Provider<TypingRepository>((ref) {
  final database = ref.watch(databaseProvider);
  final typingService = ref.watch(typingServiceProvider);
  return TypingRepository(database, typingService);
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final database = ref.watch(databaseProvider);
  final sentimentService = ref.watch(sentimentServiceProvider);
  return NotificationRepository(database, sentimentService);
});

final stressRepositoryProvider = Provider<StressRepository>((ref) {
  final database = ref.watch(databaseProvider);
  final notificationRepo = ref.watch(notificationRepositoryProvider);
  return StressRepository(database, notificationRepo);
});
