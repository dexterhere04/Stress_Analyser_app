import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [TypingSessions, NotificationRecords, StressReadings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<TypingSession>> watchAllTypingSessions() {
    return (select(
      typingSessions,
    )..orderBy([(t) => OrderingTerm.desc(t.timestamp)])).watch();
  }

  Future<List<TypingSession>> getAllTypingSessions() {
    return (select(
      typingSessions,
    )..orderBy([(t) => OrderingTerm.desc(t.timestamp)])).get();
  }

  Future<void> insertTypingSession(TypingSessionsCompanion session) {
    return into(typingSessions).insert(session);
  }

  Stream<List<NotificationRecord>> watchAllNotificationRecords() {
    return (select(
      notificationRecords,
    )..orderBy([(t) => OrderingTerm.desc(t.timestamp)])).watch();
  }

  Future<List<NotificationRecord>> getAllNotificationRecords() {
    return (select(
      notificationRecords,
    )..orderBy([(t) => OrderingTerm.desc(t.timestamp)])).get();
  }

  Future<void> insertNotificationRecord(NotificationRecordsCompanion record) {
    return into(notificationRecords).insert(record);
  }

  Stream<List<StressReading>> watchAllStressReadings() {
    return (select(
      stressReadings,
    )..orderBy([(t) => OrderingTerm.desc(t.timestamp)])).watch();
  }

  Future<List<StressReading>> getAllStressReadings() {
    return (select(
      stressReadings,
    )..orderBy([(t) => OrderingTerm.desc(t.timestamp)])).get();
  }

  Future<List<StressReading>> getStressReadingsForDateRange(
    DateTime start,
    DateTime end,
  ) {
    return (select(stressReadings)
          ..where((t) => t.timestamp.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .get();
  }

  Future<void> insertStressReading(StressReadingsCompanion reading) {
    return into(stressReadings).insert(reading);
  }

  Future<void> deleteOldRecords(Duration olderThan) async {
    final cutoff = DateTime.now().subtract(olderThan);
    await (delete(
      notificationRecords,
    )..where((t) => t.timestamp.isSmallerThanValue(cutoff))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'destresser.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
