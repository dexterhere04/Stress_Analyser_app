import 'package:drift/drift.dart';

class TypingSessions extends Table {
  TextColumn get id => text()();
  RealColumn get wpm => real()();
  RealColumn get errorRate => real()();
  RealColumn get hesitationScore => real()();
  RealColumn get rhythmVariance => real()();
  RealColumn get backspaceRatio => real()();
  IntColumn get totalKeystrokes => integer()();
  IntColumn get totalErrors => integer()();
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get sessionDurationMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class NotificationRecords extends Table {
  TextColumn get id => text()();
  TextColumn get source => text()();
  TextColumn get preview => text()();
  TextColumn get sentiment => text()();
  RealColumn get score => real()();
  DateTimeColumn get timestamp => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class StressReadings extends Table {
  TextColumn get id => text()();
  DateTimeColumn get timestamp => dateTime()();
  RealColumn get overallScore => real()();
  TextColumn get typingMetricsId =>
      text().nullable().references(TypingSessions, #id)();

  @override
  Set<Column> get primaryKey => {id};
}
