// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TypingSessionsTable extends TypingSessions
    with TableInfo<$TypingSessionsTable, TypingSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TypingSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wpmMeta = const VerificationMeta('wpm');
  @override
  late final GeneratedColumn<double> wpm = GeneratedColumn<double>(
    'wpm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorRateMeta = const VerificationMeta(
    'errorRate',
  );
  @override
  late final GeneratedColumn<double> errorRate = GeneratedColumn<double>(
    'error_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hesitationScoreMeta = const VerificationMeta(
    'hesitationScore',
  );
  @override
  late final GeneratedColumn<double> hesitationScore = GeneratedColumn<double>(
    'hesitation_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rhythmVarianceMeta = const VerificationMeta(
    'rhythmVariance',
  );
  @override
  late final GeneratedColumn<double> rhythmVariance = GeneratedColumn<double>(
    'rhythm_variance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _backspaceRatioMeta = const VerificationMeta(
    'backspaceRatio',
  );
  @override
  late final GeneratedColumn<double> backspaceRatio = GeneratedColumn<double>(
    'backspace_ratio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalKeystrokesMeta = const VerificationMeta(
    'totalKeystrokes',
  );
  @override
  late final GeneratedColumn<int> totalKeystrokes = GeneratedColumn<int>(
    'total_keystrokes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalErrorsMeta = const VerificationMeta(
    'totalErrors',
  );
  @override
  late final GeneratedColumn<int> totalErrors = GeneratedColumn<int>(
    'total_errors',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionDurationMsMeta = const VerificationMeta(
    'sessionDurationMs',
  );
  @override
  late final GeneratedColumn<int> sessionDurationMs = GeneratedColumn<int>(
    'session_duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wpm,
    errorRate,
    hesitationScore,
    rhythmVariance,
    backspaceRatio,
    totalKeystrokes,
    totalErrors,
    timestamp,
    sessionDurationMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'typing_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TypingSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('wpm')) {
      context.handle(
        _wpmMeta,
        wpm.isAcceptableOrUnknown(data['wpm']!, _wpmMeta),
      );
    } else if (isInserting) {
      context.missing(_wpmMeta);
    }
    if (data.containsKey('error_rate')) {
      context.handle(
        _errorRateMeta,
        errorRate.isAcceptableOrUnknown(data['error_rate']!, _errorRateMeta),
      );
    } else if (isInserting) {
      context.missing(_errorRateMeta);
    }
    if (data.containsKey('hesitation_score')) {
      context.handle(
        _hesitationScoreMeta,
        hesitationScore.isAcceptableOrUnknown(
          data['hesitation_score']!,
          _hesitationScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hesitationScoreMeta);
    }
    if (data.containsKey('rhythm_variance')) {
      context.handle(
        _rhythmVarianceMeta,
        rhythmVariance.isAcceptableOrUnknown(
          data['rhythm_variance']!,
          _rhythmVarianceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rhythmVarianceMeta);
    }
    if (data.containsKey('backspace_ratio')) {
      context.handle(
        _backspaceRatioMeta,
        backspaceRatio.isAcceptableOrUnknown(
          data['backspace_ratio']!,
          _backspaceRatioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_backspaceRatioMeta);
    }
    if (data.containsKey('total_keystrokes')) {
      context.handle(
        _totalKeystrokesMeta,
        totalKeystrokes.isAcceptableOrUnknown(
          data['total_keystrokes']!,
          _totalKeystrokesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalKeystrokesMeta);
    }
    if (data.containsKey('total_errors')) {
      context.handle(
        _totalErrorsMeta,
        totalErrors.isAcceptableOrUnknown(
          data['total_errors']!,
          _totalErrorsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalErrorsMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('session_duration_ms')) {
      context.handle(
        _sessionDurationMsMeta,
        sessionDurationMs.isAcceptableOrUnknown(
          data['session_duration_ms']!,
          _sessionDurationMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionDurationMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TypingSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TypingSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      wpm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wpm'],
      )!,
      errorRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}error_rate'],
      )!,
      hesitationScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hesitation_score'],
      )!,
      rhythmVariance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rhythm_variance'],
      )!,
      backspaceRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}backspace_ratio'],
      )!,
      totalKeystrokes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_keystrokes'],
      )!,
      totalErrors: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_errors'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      sessionDurationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_duration_ms'],
      )!,
    );
  }

  @override
  $TypingSessionsTable createAlias(String alias) {
    return $TypingSessionsTable(attachedDatabase, alias);
  }
}

class TypingSession extends DataClass implements Insertable<TypingSession> {
  final String id;
  final double wpm;
  final double errorRate;
  final double hesitationScore;
  final double rhythmVariance;
  final double backspaceRatio;
  final int totalKeystrokes;
  final int totalErrors;
  final DateTime timestamp;
  final int sessionDurationMs;
  const TypingSession({
    required this.id,
    required this.wpm,
    required this.errorRate,
    required this.hesitationScore,
    required this.rhythmVariance,
    required this.backspaceRatio,
    required this.totalKeystrokes,
    required this.totalErrors,
    required this.timestamp,
    required this.sessionDurationMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['wpm'] = Variable<double>(wpm);
    map['error_rate'] = Variable<double>(errorRate);
    map['hesitation_score'] = Variable<double>(hesitationScore);
    map['rhythm_variance'] = Variable<double>(rhythmVariance);
    map['backspace_ratio'] = Variable<double>(backspaceRatio);
    map['total_keystrokes'] = Variable<int>(totalKeystrokes);
    map['total_errors'] = Variable<int>(totalErrors);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['session_duration_ms'] = Variable<int>(sessionDurationMs);
    return map;
  }

  TypingSessionsCompanion toCompanion(bool nullToAbsent) {
    return TypingSessionsCompanion(
      id: Value(id),
      wpm: Value(wpm),
      errorRate: Value(errorRate),
      hesitationScore: Value(hesitationScore),
      rhythmVariance: Value(rhythmVariance),
      backspaceRatio: Value(backspaceRatio),
      totalKeystrokes: Value(totalKeystrokes),
      totalErrors: Value(totalErrors),
      timestamp: Value(timestamp),
      sessionDurationMs: Value(sessionDurationMs),
    );
  }

  factory TypingSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TypingSession(
      id: serializer.fromJson<String>(json['id']),
      wpm: serializer.fromJson<double>(json['wpm']),
      errorRate: serializer.fromJson<double>(json['errorRate']),
      hesitationScore: serializer.fromJson<double>(json['hesitationScore']),
      rhythmVariance: serializer.fromJson<double>(json['rhythmVariance']),
      backspaceRatio: serializer.fromJson<double>(json['backspaceRatio']),
      totalKeystrokes: serializer.fromJson<int>(json['totalKeystrokes']),
      totalErrors: serializer.fromJson<int>(json['totalErrors']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      sessionDurationMs: serializer.fromJson<int>(json['sessionDurationMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'wpm': serializer.toJson<double>(wpm),
      'errorRate': serializer.toJson<double>(errorRate),
      'hesitationScore': serializer.toJson<double>(hesitationScore),
      'rhythmVariance': serializer.toJson<double>(rhythmVariance),
      'backspaceRatio': serializer.toJson<double>(backspaceRatio),
      'totalKeystrokes': serializer.toJson<int>(totalKeystrokes),
      'totalErrors': serializer.toJson<int>(totalErrors),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'sessionDurationMs': serializer.toJson<int>(sessionDurationMs),
    };
  }

  TypingSession copyWith({
    String? id,
    double? wpm,
    double? errorRate,
    double? hesitationScore,
    double? rhythmVariance,
    double? backspaceRatio,
    int? totalKeystrokes,
    int? totalErrors,
    DateTime? timestamp,
    int? sessionDurationMs,
  }) => TypingSession(
    id: id ?? this.id,
    wpm: wpm ?? this.wpm,
    errorRate: errorRate ?? this.errorRate,
    hesitationScore: hesitationScore ?? this.hesitationScore,
    rhythmVariance: rhythmVariance ?? this.rhythmVariance,
    backspaceRatio: backspaceRatio ?? this.backspaceRatio,
    totalKeystrokes: totalKeystrokes ?? this.totalKeystrokes,
    totalErrors: totalErrors ?? this.totalErrors,
    timestamp: timestamp ?? this.timestamp,
    sessionDurationMs: sessionDurationMs ?? this.sessionDurationMs,
  );
  TypingSession copyWithCompanion(TypingSessionsCompanion data) {
    return TypingSession(
      id: data.id.present ? data.id.value : this.id,
      wpm: data.wpm.present ? data.wpm.value : this.wpm,
      errorRate: data.errorRate.present ? data.errorRate.value : this.errorRate,
      hesitationScore: data.hesitationScore.present
          ? data.hesitationScore.value
          : this.hesitationScore,
      rhythmVariance: data.rhythmVariance.present
          ? data.rhythmVariance.value
          : this.rhythmVariance,
      backspaceRatio: data.backspaceRatio.present
          ? data.backspaceRatio.value
          : this.backspaceRatio,
      totalKeystrokes: data.totalKeystrokes.present
          ? data.totalKeystrokes.value
          : this.totalKeystrokes,
      totalErrors: data.totalErrors.present
          ? data.totalErrors.value
          : this.totalErrors,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      sessionDurationMs: data.sessionDurationMs.present
          ? data.sessionDurationMs.value
          : this.sessionDurationMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TypingSession(')
          ..write('id: $id, ')
          ..write('wpm: $wpm, ')
          ..write('errorRate: $errorRate, ')
          ..write('hesitationScore: $hesitationScore, ')
          ..write('rhythmVariance: $rhythmVariance, ')
          ..write('backspaceRatio: $backspaceRatio, ')
          ..write('totalKeystrokes: $totalKeystrokes, ')
          ..write('totalErrors: $totalErrors, ')
          ..write('timestamp: $timestamp, ')
          ..write('sessionDurationMs: $sessionDurationMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    wpm,
    errorRate,
    hesitationScore,
    rhythmVariance,
    backspaceRatio,
    totalKeystrokes,
    totalErrors,
    timestamp,
    sessionDurationMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TypingSession &&
          other.id == this.id &&
          other.wpm == this.wpm &&
          other.errorRate == this.errorRate &&
          other.hesitationScore == this.hesitationScore &&
          other.rhythmVariance == this.rhythmVariance &&
          other.backspaceRatio == this.backspaceRatio &&
          other.totalKeystrokes == this.totalKeystrokes &&
          other.totalErrors == this.totalErrors &&
          other.timestamp == this.timestamp &&
          other.sessionDurationMs == this.sessionDurationMs);
}

class TypingSessionsCompanion extends UpdateCompanion<TypingSession> {
  final Value<String> id;
  final Value<double> wpm;
  final Value<double> errorRate;
  final Value<double> hesitationScore;
  final Value<double> rhythmVariance;
  final Value<double> backspaceRatio;
  final Value<int> totalKeystrokes;
  final Value<int> totalErrors;
  final Value<DateTime> timestamp;
  final Value<int> sessionDurationMs;
  final Value<int> rowid;
  const TypingSessionsCompanion({
    this.id = const Value.absent(),
    this.wpm = const Value.absent(),
    this.errorRate = const Value.absent(),
    this.hesitationScore = const Value.absent(),
    this.rhythmVariance = const Value.absent(),
    this.backspaceRatio = const Value.absent(),
    this.totalKeystrokes = const Value.absent(),
    this.totalErrors = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.sessionDurationMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TypingSessionsCompanion.insert({
    required String id,
    required double wpm,
    required double errorRate,
    required double hesitationScore,
    required double rhythmVariance,
    required double backspaceRatio,
    required int totalKeystrokes,
    required int totalErrors,
    required DateTime timestamp,
    required int sessionDurationMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       wpm = Value(wpm),
       errorRate = Value(errorRate),
       hesitationScore = Value(hesitationScore),
       rhythmVariance = Value(rhythmVariance),
       backspaceRatio = Value(backspaceRatio),
       totalKeystrokes = Value(totalKeystrokes),
       totalErrors = Value(totalErrors),
       timestamp = Value(timestamp),
       sessionDurationMs = Value(sessionDurationMs);
  static Insertable<TypingSession> custom({
    Expression<String>? id,
    Expression<double>? wpm,
    Expression<double>? errorRate,
    Expression<double>? hesitationScore,
    Expression<double>? rhythmVariance,
    Expression<double>? backspaceRatio,
    Expression<int>? totalKeystrokes,
    Expression<int>? totalErrors,
    Expression<DateTime>? timestamp,
    Expression<int>? sessionDurationMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wpm != null) 'wpm': wpm,
      if (errorRate != null) 'error_rate': errorRate,
      if (hesitationScore != null) 'hesitation_score': hesitationScore,
      if (rhythmVariance != null) 'rhythm_variance': rhythmVariance,
      if (backspaceRatio != null) 'backspace_ratio': backspaceRatio,
      if (totalKeystrokes != null) 'total_keystrokes': totalKeystrokes,
      if (totalErrors != null) 'total_errors': totalErrors,
      if (timestamp != null) 'timestamp': timestamp,
      if (sessionDurationMs != null) 'session_duration_ms': sessionDurationMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TypingSessionsCompanion copyWith({
    Value<String>? id,
    Value<double>? wpm,
    Value<double>? errorRate,
    Value<double>? hesitationScore,
    Value<double>? rhythmVariance,
    Value<double>? backspaceRatio,
    Value<int>? totalKeystrokes,
    Value<int>? totalErrors,
    Value<DateTime>? timestamp,
    Value<int>? sessionDurationMs,
    Value<int>? rowid,
  }) {
    return TypingSessionsCompanion(
      id: id ?? this.id,
      wpm: wpm ?? this.wpm,
      errorRate: errorRate ?? this.errorRate,
      hesitationScore: hesitationScore ?? this.hesitationScore,
      rhythmVariance: rhythmVariance ?? this.rhythmVariance,
      backspaceRatio: backspaceRatio ?? this.backspaceRatio,
      totalKeystrokes: totalKeystrokes ?? this.totalKeystrokes,
      totalErrors: totalErrors ?? this.totalErrors,
      timestamp: timestamp ?? this.timestamp,
      sessionDurationMs: sessionDurationMs ?? this.sessionDurationMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (wpm.present) {
      map['wpm'] = Variable<double>(wpm.value);
    }
    if (errorRate.present) {
      map['error_rate'] = Variable<double>(errorRate.value);
    }
    if (hesitationScore.present) {
      map['hesitation_score'] = Variable<double>(hesitationScore.value);
    }
    if (rhythmVariance.present) {
      map['rhythm_variance'] = Variable<double>(rhythmVariance.value);
    }
    if (backspaceRatio.present) {
      map['backspace_ratio'] = Variable<double>(backspaceRatio.value);
    }
    if (totalKeystrokes.present) {
      map['total_keystrokes'] = Variable<int>(totalKeystrokes.value);
    }
    if (totalErrors.present) {
      map['total_errors'] = Variable<int>(totalErrors.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (sessionDurationMs.present) {
      map['session_duration_ms'] = Variable<int>(sessionDurationMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TypingSessionsCompanion(')
          ..write('id: $id, ')
          ..write('wpm: $wpm, ')
          ..write('errorRate: $errorRate, ')
          ..write('hesitationScore: $hesitationScore, ')
          ..write('rhythmVariance: $rhythmVariance, ')
          ..write('backspaceRatio: $backspaceRatio, ')
          ..write('totalKeystrokes: $totalKeystrokes, ')
          ..write('totalErrors: $totalErrors, ')
          ..write('timestamp: $timestamp, ')
          ..write('sessionDurationMs: $sessionDurationMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationRecordsTable extends NotificationRecords
    with TableInfo<$NotificationRecordsTable, NotificationRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previewMeta = const VerificationMeta(
    'preview',
  );
  @override
  late final GeneratedColumn<String> preview = GeneratedColumn<String>(
    'preview',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sentimentMeta = const VerificationMeta(
    'sentiment',
  );
  @override
  late final GeneratedColumn<String> sentiment = GeneratedColumn<String>(
    'sentiment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    preview,
    sentiment,
    score,
    timestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('preview')) {
      context.handle(
        _previewMeta,
        preview.isAcceptableOrUnknown(data['preview']!, _previewMeta),
      );
    } else if (isInserting) {
      context.missing(_previewMeta);
    }
    if (data.containsKey('sentiment')) {
      context.handle(
        _sentimentMeta,
        sentiment.isAcceptableOrUnknown(data['sentiment']!, _sentimentMeta),
      );
    } else if (isInserting) {
      context.missing(_sentimentMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      preview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preview'],
      )!,
      sentiment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sentiment'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $NotificationRecordsTable createAlias(String alias) {
    return $NotificationRecordsTable(attachedDatabase, alias);
  }
}

class NotificationRecord extends DataClass
    implements Insertable<NotificationRecord> {
  final String id;
  final String source;
  final String preview;
  final String sentiment;
  final double score;
  final DateTime timestamp;
  const NotificationRecord({
    required this.id,
    required this.source,
    required this.preview,
    required this.sentiment,
    required this.score,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source'] = Variable<String>(source);
    map['preview'] = Variable<String>(preview);
    map['sentiment'] = Variable<String>(sentiment);
    map['score'] = Variable<double>(score);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  NotificationRecordsCompanion toCompanion(bool nullToAbsent) {
    return NotificationRecordsCompanion(
      id: Value(id),
      source: Value(source),
      preview: Value(preview),
      sentiment: Value(sentiment),
      score: Value(score),
      timestamp: Value(timestamp),
    );
  }

  factory NotificationRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationRecord(
      id: serializer.fromJson<String>(json['id']),
      source: serializer.fromJson<String>(json['source']),
      preview: serializer.fromJson<String>(json['preview']),
      sentiment: serializer.fromJson<String>(json['sentiment']),
      score: serializer.fromJson<double>(json['score']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source': serializer.toJson<String>(source),
      'preview': serializer.toJson<String>(preview),
      'sentiment': serializer.toJson<String>(sentiment),
      'score': serializer.toJson<double>(score),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  NotificationRecord copyWith({
    String? id,
    String? source,
    String? preview,
    String? sentiment,
    double? score,
    DateTime? timestamp,
  }) => NotificationRecord(
    id: id ?? this.id,
    source: source ?? this.source,
    preview: preview ?? this.preview,
    sentiment: sentiment ?? this.sentiment,
    score: score ?? this.score,
    timestamp: timestamp ?? this.timestamp,
  );
  NotificationRecord copyWithCompanion(NotificationRecordsCompanion data) {
    return NotificationRecord(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      preview: data.preview.present ? data.preview.value : this.preview,
      sentiment: data.sentiment.present ? data.sentiment.value : this.sentiment,
      score: data.score.present ? data.score.value : this.score,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationRecord(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('preview: $preview, ')
          ..write('sentiment: $sentiment, ')
          ..write('score: $score, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, source, preview, sentiment, score, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationRecord &&
          other.id == this.id &&
          other.source == this.source &&
          other.preview == this.preview &&
          other.sentiment == this.sentiment &&
          other.score == this.score &&
          other.timestamp == this.timestamp);
}

class NotificationRecordsCompanion extends UpdateCompanion<NotificationRecord> {
  final Value<String> id;
  final Value<String> source;
  final Value<String> preview;
  final Value<String> sentiment;
  final Value<double> score;
  final Value<DateTime> timestamp;
  final Value<int> rowid;
  const NotificationRecordsCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.preview = const Value.absent(),
    this.sentiment = const Value.absent(),
    this.score = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationRecordsCompanion.insert({
    required String id,
    required String source,
    required String preview,
    required String sentiment,
    required double score,
    required DateTime timestamp,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       source = Value(source),
       preview = Value(preview),
       sentiment = Value(sentiment),
       score = Value(score),
       timestamp = Value(timestamp);
  static Insertable<NotificationRecord> custom({
    Expression<String>? id,
    Expression<String>? source,
    Expression<String>? preview,
    Expression<String>? sentiment,
    Expression<double>? score,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (preview != null) 'preview': preview,
      if (sentiment != null) 'sentiment': sentiment,
      if (score != null) 'score': score,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? source,
    Value<String>? preview,
    Value<String>? sentiment,
    Value<double>? score,
    Value<DateTime>? timestamp,
    Value<int>? rowid,
  }) {
    return NotificationRecordsCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      preview: preview ?? this.preview,
      sentiment: sentiment ?? this.sentiment,
      score: score ?? this.score,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (preview.present) {
      map['preview'] = Variable<String>(preview.value);
    }
    if (sentiment.present) {
      map['sentiment'] = Variable<String>(sentiment.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationRecordsCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('preview: $preview, ')
          ..write('sentiment: $sentiment, ')
          ..write('score: $score, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StressReadingsTable extends StressReadings
    with TableInfo<$StressReadingsTable, StressReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StressReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _overallScoreMeta = const VerificationMeta(
    'overallScore',
  );
  @override
  late final GeneratedColumn<double> overallScore = GeneratedColumn<double>(
    'overall_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typingMetricsIdMeta = const VerificationMeta(
    'typingMetricsId',
  );
  @override
  late final GeneratedColumn<String> typingMetricsId = GeneratedColumn<String>(
    'typing_metrics_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES typing_sessions (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    overallScore,
    typingMetricsId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stress_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<StressReading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('overall_score')) {
      context.handle(
        _overallScoreMeta,
        overallScore.isAcceptableOrUnknown(
          data['overall_score']!,
          _overallScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_overallScoreMeta);
    }
    if (data.containsKey('typing_metrics_id')) {
      context.handle(
        _typingMetricsIdMeta,
        typingMetricsId.isAcceptableOrUnknown(
          data['typing_metrics_id']!,
          _typingMetricsIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StressReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StressReading(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      overallScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}overall_score'],
      )!,
      typingMetricsId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}typing_metrics_id'],
      ),
    );
  }

  @override
  $StressReadingsTable createAlias(String alias) {
    return $StressReadingsTable(attachedDatabase, alias);
  }
}

class StressReading extends DataClass implements Insertable<StressReading> {
  final String id;
  final DateTime timestamp;
  final double overallScore;
  final String? typingMetricsId;
  const StressReading({
    required this.id,
    required this.timestamp,
    required this.overallScore,
    this.typingMetricsId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['overall_score'] = Variable<double>(overallScore);
    if (!nullToAbsent || typingMetricsId != null) {
      map['typing_metrics_id'] = Variable<String>(typingMetricsId);
    }
    return map;
  }

  StressReadingsCompanion toCompanion(bool nullToAbsent) {
    return StressReadingsCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      overallScore: Value(overallScore),
      typingMetricsId: typingMetricsId == null && nullToAbsent
          ? const Value.absent()
          : Value(typingMetricsId),
    );
  }

  factory StressReading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StressReading(
      id: serializer.fromJson<String>(json['id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      overallScore: serializer.fromJson<double>(json['overallScore']),
      typingMetricsId: serializer.fromJson<String?>(json['typingMetricsId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'overallScore': serializer.toJson<double>(overallScore),
      'typingMetricsId': serializer.toJson<String?>(typingMetricsId),
    };
  }

  StressReading copyWith({
    String? id,
    DateTime? timestamp,
    double? overallScore,
    Value<String?> typingMetricsId = const Value.absent(),
  }) => StressReading(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    overallScore: overallScore ?? this.overallScore,
    typingMetricsId: typingMetricsId.present
        ? typingMetricsId.value
        : this.typingMetricsId,
  );
  StressReading copyWithCompanion(StressReadingsCompanion data) {
    return StressReading(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      overallScore: data.overallScore.present
          ? data.overallScore.value
          : this.overallScore,
      typingMetricsId: data.typingMetricsId.present
          ? data.typingMetricsId.value
          : this.typingMetricsId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StressReading(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('overallScore: $overallScore, ')
          ..write('typingMetricsId: $typingMetricsId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, timestamp, overallScore, typingMetricsId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StressReading &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.overallScore == this.overallScore &&
          other.typingMetricsId == this.typingMetricsId);
}

class StressReadingsCompanion extends UpdateCompanion<StressReading> {
  final Value<String> id;
  final Value<DateTime> timestamp;
  final Value<double> overallScore;
  final Value<String?> typingMetricsId;
  final Value<int> rowid;
  const StressReadingsCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.overallScore = const Value.absent(),
    this.typingMetricsId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StressReadingsCompanion.insert({
    required String id,
    required DateTime timestamp,
    required double overallScore,
    this.typingMetricsId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       timestamp = Value(timestamp),
       overallScore = Value(overallScore);
  static Insertable<StressReading> custom({
    Expression<String>? id,
    Expression<DateTime>? timestamp,
    Expression<double>? overallScore,
    Expression<String>? typingMetricsId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (overallScore != null) 'overall_score': overallScore,
      if (typingMetricsId != null) 'typing_metrics_id': typingMetricsId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StressReadingsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? timestamp,
    Value<double>? overallScore,
    Value<String?>? typingMetricsId,
    Value<int>? rowid,
  }) {
    return StressReadingsCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      overallScore: overallScore ?? this.overallScore,
      typingMetricsId: typingMetricsId ?? this.typingMetricsId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (overallScore.present) {
      map['overall_score'] = Variable<double>(overallScore.value);
    }
    if (typingMetricsId.present) {
      map['typing_metrics_id'] = Variable<String>(typingMetricsId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StressReadingsCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('overallScore: $overallScore, ')
          ..write('typingMetricsId: $typingMetricsId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TypingSessionsTable typingSessions = $TypingSessionsTable(this);
  late final $NotificationRecordsTable notificationRecords =
      $NotificationRecordsTable(this);
  late final $StressReadingsTable stressReadings = $StressReadingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    typingSessions,
    notificationRecords,
    stressReadings,
  ];
}

typedef $$TypingSessionsTableCreateCompanionBuilder =
    TypingSessionsCompanion Function({
      required String id,
      required double wpm,
      required double errorRate,
      required double hesitationScore,
      required double rhythmVariance,
      required double backspaceRatio,
      required int totalKeystrokes,
      required int totalErrors,
      required DateTime timestamp,
      required int sessionDurationMs,
      Value<int> rowid,
    });
typedef $$TypingSessionsTableUpdateCompanionBuilder =
    TypingSessionsCompanion Function({
      Value<String> id,
      Value<double> wpm,
      Value<double> errorRate,
      Value<double> hesitationScore,
      Value<double> rhythmVariance,
      Value<double> backspaceRatio,
      Value<int> totalKeystrokes,
      Value<int> totalErrors,
      Value<DateTime> timestamp,
      Value<int> sessionDurationMs,
      Value<int> rowid,
    });

final class $$TypingSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $TypingSessionsTable, TypingSession> {
  $$TypingSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$StressReadingsTable, List<StressReading>>
  _stressReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stressReadings,
    aliasName: $_aliasNameGenerator(
      db.typingSessions.id,
      db.stressReadings.typingMetricsId,
    ),
  );

  $$StressReadingsTableProcessedTableManager get stressReadingsRefs {
    final manager = $$StressReadingsTableTableManager($_db, $_db.stressReadings)
        .filter(
          (f) => f.typingMetricsId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_stressReadingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TypingSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $TypingSessionsTable> {
  $$TypingSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wpm => $composableBuilder(
    column: $table.wpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get errorRate => $composableBuilder(
    column: $table.errorRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hesitationScore => $composableBuilder(
    column: $table.hesitationScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rhythmVariance => $composableBuilder(
    column: $table.rhythmVariance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get backspaceRatio => $composableBuilder(
    column: $table.backspaceRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalKeystrokes => $composableBuilder(
    column: $table.totalKeystrokes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalErrors => $composableBuilder(
    column: $table.totalErrors,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionDurationMs => $composableBuilder(
    column: $table.sessionDurationMs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> stressReadingsRefs(
    Expression<bool> Function($$StressReadingsTableFilterComposer f) f,
  ) {
    final $$StressReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stressReadings,
      getReferencedColumn: (t) => t.typingMetricsId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StressReadingsTableFilterComposer(
            $db: $db,
            $table: $db.stressReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TypingSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TypingSessionsTable> {
  $$TypingSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wpm => $composableBuilder(
    column: $table.wpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get errorRate => $composableBuilder(
    column: $table.errorRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hesitationScore => $composableBuilder(
    column: $table.hesitationScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rhythmVariance => $composableBuilder(
    column: $table.rhythmVariance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get backspaceRatio => $composableBuilder(
    column: $table.backspaceRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalKeystrokes => $composableBuilder(
    column: $table.totalKeystrokes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalErrors => $composableBuilder(
    column: $table.totalErrors,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionDurationMs => $composableBuilder(
    column: $table.sessionDurationMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TypingSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TypingSessionsTable> {
  $$TypingSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get wpm =>
      $composableBuilder(column: $table.wpm, builder: (column) => column);

  GeneratedColumn<double> get errorRate =>
      $composableBuilder(column: $table.errorRate, builder: (column) => column);

  GeneratedColumn<double> get hesitationScore => $composableBuilder(
    column: $table.hesitationScore,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rhythmVariance => $composableBuilder(
    column: $table.rhythmVariance,
    builder: (column) => column,
  );

  GeneratedColumn<double> get backspaceRatio => $composableBuilder(
    column: $table.backspaceRatio,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalKeystrokes => $composableBuilder(
    column: $table.totalKeystrokes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalErrors => $composableBuilder(
    column: $table.totalErrors,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get sessionDurationMs => $composableBuilder(
    column: $table.sessionDurationMs,
    builder: (column) => column,
  );

  Expression<T> stressReadingsRefs<T extends Object>(
    Expression<T> Function($$StressReadingsTableAnnotationComposer a) f,
  ) {
    final $$StressReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stressReadings,
      getReferencedColumn: (t) => t.typingMetricsId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StressReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.stressReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TypingSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TypingSessionsTable,
          TypingSession,
          $$TypingSessionsTableFilterComposer,
          $$TypingSessionsTableOrderingComposer,
          $$TypingSessionsTableAnnotationComposer,
          $$TypingSessionsTableCreateCompanionBuilder,
          $$TypingSessionsTableUpdateCompanionBuilder,
          (TypingSession, $$TypingSessionsTableReferences),
          TypingSession,
          PrefetchHooks Function({bool stressReadingsRefs})
        > {
  $$TypingSessionsTableTableManager(
    _$AppDatabase db,
    $TypingSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TypingSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TypingSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TypingSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<double> wpm = const Value.absent(),
                Value<double> errorRate = const Value.absent(),
                Value<double> hesitationScore = const Value.absent(),
                Value<double> rhythmVariance = const Value.absent(),
                Value<double> backspaceRatio = const Value.absent(),
                Value<int> totalKeystrokes = const Value.absent(),
                Value<int> totalErrors = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> sessionDurationMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TypingSessionsCompanion(
                id: id,
                wpm: wpm,
                errorRate: errorRate,
                hesitationScore: hesitationScore,
                rhythmVariance: rhythmVariance,
                backspaceRatio: backspaceRatio,
                totalKeystrokes: totalKeystrokes,
                totalErrors: totalErrors,
                timestamp: timestamp,
                sessionDurationMs: sessionDurationMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required double wpm,
                required double errorRate,
                required double hesitationScore,
                required double rhythmVariance,
                required double backspaceRatio,
                required int totalKeystrokes,
                required int totalErrors,
                required DateTime timestamp,
                required int sessionDurationMs,
                Value<int> rowid = const Value.absent(),
              }) => TypingSessionsCompanion.insert(
                id: id,
                wpm: wpm,
                errorRate: errorRate,
                hesitationScore: hesitationScore,
                rhythmVariance: rhythmVariance,
                backspaceRatio: backspaceRatio,
                totalKeystrokes: totalKeystrokes,
                totalErrors: totalErrors,
                timestamp: timestamp,
                sessionDurationMs: sessionDurationMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TypingSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({stressReadingsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (stressReadingsRefs) db.stressReadings,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (stressReadingsRefs)
                    await $_getPrefetchedData<
                      TypingSession,
                      $TypingSessionsTable,
                      StressReading
                    >(
                      currentTable: table,
                      referencedTable: $$TypingSessionsTableReferences
                          ._stressReadingsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TypingSessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).stressReadingsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.typingMetricsId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TypingSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TypingSessionsTable,
      TypingSession,
      $$TypingSessionsTableFilterComposer,
      $$TypingSessionsTableOrderingComposer,
      $$TypingSessionsTableAnnotationComposer,
      $$TypingSessionsTableCreateCompanionBuilder,
      $$TypingSessionsTableUpdateCompanionBuilder,
      (TypingSession, $$TypingSessionsTableReferences),
      TypingSession,
      PrefetchHooks Function({bool stressReadingsRefs})
    >;
typedef $$NotificationRecordsTableCreateCompanionBuilder =
    NotificationRecordsCompanion Function({
      required String id,
      required String source,
      required String preview,
      required String sentiment,
      required double score,
      required DateTime timestamp,
      Value<int> rowid,
    });
typedef $$NotificationRecordsTableUpdateCompanionBuilder =
    NotificationRecordsCompanion Function({
      Value<String> id,
      Value<String> source,
      Value<String> preview,
      Value<String> sentiment,
      Value<double> score,
      Value<DateTime> timestamp,
      Value<int> rowid,
    });

class $$NotificationRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationRecordsTable> {
  $$NotificationRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preview => $composableBuilder(
    column: $table.preview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sentiment => $composableBuilder(
    column: $table.sentiment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationRecordsTable> {
  $$NotificationRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preview => $composableBuilder(
    column: $table.preview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sentiment => $composableBuilder(
    column: $table.sentiment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationRecordsTable> {
  $$NotificationRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get preview =>
      $composableBuilder(column: $table.preview, builder: (column) => column);

  GeneratedColumn<String> get sentiment =>
      $composableBuilder(column: $table.sentiment, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$NotificationRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationRecordsTable,
          NotificationRecord,
          $$NotificationRecordsTableFilterComposer,
          $$NotificationRecordsTableOrderingComposer,
          $$NotificationRecordsTableAnnotationComposer,
          $$NotificationRecordsTableCreateCompanionBuilder,
          $$NotificationRecordsTableUpdateCompanionBuilder,
          (
            NotificationRecord,
            BaseReferences<
              _$AppDatabase,
              $NotificationRecordsTable,
              NotificationRecord
            >,
          ),
          NotificationRecord,
          PrefetchHooks Function()
        > {
  $$NotificationRecordsTableTableManager(
    _$AppDatabase db,
    $NotificationRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NotificationRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> preview = const Value.absent(),
                Value<String> sentiment = const Value.absent(),
                Value<double> score = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationRecordsCompanion(
                id: id,
                source: source,
                preview: preview,
                sentiment: sentiment,
                score: score,
                timestamp: timestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String source,
                required String preview,
                required String sentiment,
                required double score,
                required DateTime timestamp,
                Value<int> rowid = const Value.absent(),
              }) => NotificationRecordsCompanion.insert(
                id: id,
                source: source,
                preview: preview,
                sentiment: sentiment,
                score: score,
                timestamp: timestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationRecordsTable,
      NotificationRecord,
      $$NotificationRecordsTableFilterComposer,
      $$NotificationRecordsTableOrderingComposer,
      $$NotificationRecordsTableAnnotationComposer,
      $$NotificationRecordsTableCreateCompanionBuilder,
      $$NotificationRecordsTableUpdateCompanionBuilder,
      (
        NotificationRecord,
        BaseReferences<
          _$AppDatabase,
          $NotificationRecordsTable,
          NotificationRecord
        >,
      ),
      NotificationRecord,
      PrefetchHooks Function()
    >;
typedef $$StressReadingsTableCreateCompanionBuilder =
    StressReadingsCompanion Function({
      required String id,
      required DateTime timestamp,
      required double overallScore,
      Value<String?> typingMetricsId,
      Value<int> rowid,
    });
typedef $$StressReadingsTableUpdateCompanionBuilder =
    StressReadingsCompanion Function({
      Value<String> id,
      Value<DateTime> timestamp,
      Value<double> overallScore,
      Value<String?> typingMetricsId,
      Value<int> rowid,
    });

final class $$StressReadingsTableReferences
    extends BaseReferences<_$AppDatabase, $StressReadingsTable, StressReading> {
  $$StressReadingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TypingSessionsTable _typingMetricsIdTable(_$AppDatabase db) =>
      db.typingSessions.createAlias(
        $_aliasNameGenerator(
          db.stressReadings.typingMetricsId,
          db.typingSessions.id,
        ),
      );

  $$TypingSessionsTableProcessedTableManager? get typingMetricsId {
    final $_column = $_itemColumn<String>('typing_metrics_id');
    if ($_column == null) return null;
    final manager = $$TypingSessionsTableTableManager(
      $_db,
      $_db.typingSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typingMetricsIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StressReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $StressReadingsTable> {
  $$StressReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get overallScore => $composableBuilder(
    column: $table.overallScore,
    builder: (column) => ColumnFilters(column),
  );

  $$TypingSessionsTableFilterComposer get typingMetricsId {
    final $$TypingSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typingMetricsId,
      referencedTable: $db.typingSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypingSessionsTableFilterComposer(
            $db: $db,
            $table: $db.typingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StressReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $StressReadingsTable> {
  $$StressReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get overallScore => $composableBuilder(
    column: $table.overallScore,
    builder: (column) => ColumnOrderings(column),
  );

  $$TypingSessionsTableOrderingComposer get typingMetricsId {
    final $$TypingSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typingMetricsId,
      referencedTable: $db.typingSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypingSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.typingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StressReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StressReadingsTable> {
  $$StressReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get overallScore => $composableBuilder(
    column: $table.overallScore,
    builder: (column) => column,
  );

  $$TypingSessionsTableAnnotationComposer get typingMetricsId {
    final $$TypingSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typingMetricsId,
      referencedTable: $db.typingSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypingSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.typingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StressReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StressReadingsTable,
          StressReading,
          $$StressReadingsTableFilterComposer,
          $$StressReadingsTableOrderingComposer,
          $$StressReadingsTableAnnotationComposer,
          $$StressReadingsTableCreateCompanionBuilder,
          $$StressReadingsTableUpdateCompanionBuilder,
          (StressReading, $$StressReadingsTableReferences),
          StressReading,
          PrefetchHooks Function({bool typingMetricsId})
        > {
  $$StressReadingsTableTableManager(
    _$AppDatabase db,
    $StressReadingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StressReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StressReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StressReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double> overallScore = const Value.absent(),
                Value<String?> typingMetricsId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StressReadingsCompanion(
                id: id,
                timestamp: timestamp,
                overallScore: overallScore,
                typingMetricsId: typingMetricsId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime timestamp,
                required double overallScore,
                Value<String?> typingMetricsId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StressReadingsCompanion.insert(
                id: id,
                timestamp: timestamp,
                overallScore: overallScore,
                typingMetricsId: typingMetricsId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StressReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({typingMetricsId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (typingMetricsId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.typingMetricsId,
                                referencedTable: $$StressReadingsTableReferences
                                    ._typingMetricsIdTable(db),
                                referencedColumn:
                                    $$StressReadingsTableReferences
                                        ._typingMetricsIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StressReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StressReadingsTable,
      StressReading,
      $$StressReadingsTableFilterComposer,
      $$StressReadingsTableOrderingComposer,
      $$StressReadingsTableAnnotationComposer,
      $$StressReadingsTableCreateCompanionBuilder,
      $$StressReadingsTableUpdateCompanionBuilder,
      (StressReading, $$StressReadingsTableReferences),
      StressReading,
      PrefetchHooks Function({bool typingMetricsId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TypingSessionsTableTableManager get typingSessions =>
      $$TypingSessionsTableTableManager(_db, _db.typingSessions);
  $$NotificationRecordsTableTableManager get notificationRecords =>
      $$NotificationRecordsTableTableManager(_db, _db.notificationRecords);
  $$StressReadingsTableTableManager get stressReadings =>
      $$StressReadingsTableTableManager(_db, _db.stressReadings);
}
