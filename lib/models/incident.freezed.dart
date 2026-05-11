// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'incident.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Incident _$IncidentFromJson(Map<String, dynamic> json) {
  return _Incident.fromJson(json);
}

/// @nodoc
mixin _$Incident {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Severity get severity => throw _privateConstructorUsedError;
  String get sourceIp => throw _privateConstructorUsedError;
  String? get targetSystem => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // open, investigating, resolved
  List<String> get tags => throw _privateConstructorUsedError;
  String? get affectedUser => throw _privateConstructorUsedError;
  int get eventCount => throw _privateConstructorUsedError;

  /// Serializes this Incident to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Incident
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IncidentCopyWith<Incident> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncidentCopyWith<$Res> {
  factory $IncidentCopyWith(Incident value, $Res Function(Incident) then) =
      _$IncidentCopyWithImpl<$Res, Incident>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      Severity severity,
      String sourceIp,
      String? targetSystem,
      DateTime timestamp,
      DateTime? resolvedAt,
      String status,
      List<String> tags,
      String? affectedUser,
      int eventCount});
}

/// @nodoc
class _$IncidentCopyWithImpl<$Res, $Val extends Incident>
    implements $IncidentCopyWith<$Res> {
  _$IncidentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Incident
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? severity = null,
    Object? sourceIp = null,
    Object? targetSystem = freezed,
    Object? timestamp = null,
    Object? resolvedAt = freezed,
    Object? status = null,
    Object? tags = null,
    Object? affectedUser = freezed,
    Object? eventCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as Severity,
      sourceIp: null == sourceIp
          ? _value.sourceIp
          : sourceIp // ignore: cast_nullable_to_non_nullable
              as String,
      targetSystem: freezed == targetSystem
          ? _value.targetSystem
          : targetSystem // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      affectedUser: freezed == affectedUser
          ? _value.affectedUser
          : affectedUser // ignore: cast_nullable_to_non_nullable
              as String?,
      eventCount: null == eventCount
          ? _value.eventCount
          : eventCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IncidentImplCopyWith<$Res>
    implements $IncidentCopyWith<$Res> {
  factory _$$IncidentImplCopyWith(
          _$IncidentImpl value, $Res Function(_$IncidentImpl) then) =
      __$$IncidentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      Severity severity,
      String sourceIp,
      String? targetSystem,
      DateTime timestamp,
      DateTime? resolvedAt,
      String status,
      List<String> tags,
      String? affectedUser,
      int eventCount});
}

/// @nodoc
class __$$IncidentImplCopyWithImpl<$Res>
    extends _$IncidentCopyWithImpl<$Res, _$IncidentImpl>
    implements _$$IncidentImplCopyWith<$Res> {
  __$$IncidentImplCopyWithImpl(
      _$IncidentImpl _value, $Res Function(_$IncidentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Incident
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? severity = null,
    Object? sourceIp = null,
    Object? targetSystem = freezed,
    Object? timestamp = null,
    Object? resolvedAt = freezed,
    Object? status = null,
    Object? tags = null,
    Object? affectedUser = freezed,
    Object? eventCount = null,
  }) {
    return _then(_$IncidentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as Severity,
      sourceIp: null == sourceIp
          ? _value.sourceIp
          : sourceIp // ignore: cast_nullable_to_non_nullable
              as String,
      targetSystem: freezed == targetSystem
          ? _value.targetSystem
          : targetSystem // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      affectedUser: freezed == affectedUser
          ? _value.affectedUser
          : affectedUser // ignore: cast_nullable_to_non_nullable
              as String?,
      eventCount: null == eventCount
          ? _value.eventCount
          : eventCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IncidentImpl implements _Incident {
  const _$IncidentImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.severity,
      required this.sourceIp,
      required this.targetSystem,
      required this.timestamp,
      required this.resolvedAt,
      required this.status,
      required final List<String> tags,
      required this.affectedUser,
      required this.eventCount})
      : _tags = tags;

  factory _$IncidentImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncidentImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final Severity severity;
  @override
  final String sourceIp;
  @override
  final String? targetSystem;
  @override
  final DateTime timestamp;
  @override
  final DateTime? resolvedAt;
  @override
  final String status;
// open, investigating, resolved
  final List<String> _tags;
// open, investigating, resolved
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String? affectedUser;
  @override
  final int eventCount;

  @override
  String toString() {
    return 'Incident(id: $id, title: $title, description: $description, severity: $severity, sourceIp: $sourceIp, targetSystem: $targetSystem, timestamp: $timestamp, resolvedAt: $resolvedAt, status: $status, tags: $tags, affectedUser: $affectedUser, eventCount: $eventCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncidentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.sourceIp, sourceIp) ||
                other.sourceIp == sourceIp) &&
            (identical(other.targetSystem, targetSystem) ||
                other.targetSystem == targetSystem) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.affectedUser, affectedUser) ||
                other.affectedUser == affectedUser) &&
            (identical(other.eventCount, eventCount) ||
                other.eventCount == eventCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      severity,
      sourceIp,
      targetSystem,
      timestamp,
      resolvedAt,
      status,
      const DeepCollectionEquality().hash(_tags),
      affectedUser,
      eventCount);

  /// Create a copy of Incident
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncidentImplCopyWith<_$IncidentImpl> get copyWith =>
      __$$IncidentImplCopyWithImpl<_$IncidentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncidentImplToJson(
      this,
    );
  }
}

abstract class _Incident implements Incident {
  const factory _Incident(
      {required final String id,
      required final String title,
      required final String description,
      required final Severity severity,
      required final String sourceIp,
      required final String? targetSystem,
      required final DateTime timestamp,
      required final DateTime? resolvedAt,
      required final String status,
      required final List<String> tags,
      required final String? affectedUser,
      required final int eventCount}) = _$IncidentImpl;

  factory _Incident.fromJson(Map<String, dynamic> json) =
      _$IncidentImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  Severity get severity;
  @override
  String get sourceIp;
  @override
  String? get targetSystem;
  @override
  DateTime get timestamp;
  @override
  DateTime? get resolvedAt;
  @override
  String get status; // open, investigating, resolved
  @override
  List<String> get tags;
  @override
  String? get affectedUser;
  @override
  int get eventCount;

  /// Create a copy of Incident
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncidentImplCopyWith<_$IncidentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimelineEvent _$TimelineEventFromJson(Map<String, dynamic> json) {
  return _TimelineEvent.fromJson(json);
}

/// @nodoc
mixin _$TimelineEvent {
  String get id => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get eventType => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get metadata => throw _privateConstructorUsedError;

  /// Serializes this TimelineEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimelineEventCopyWith<TimelineEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineEventCopyWith<$Res> {
  factory $TimelineEventCopyWith(
          TimelineEvent value, $Res Function(TimelineEvent) then) =
      _$TimelineEventCopyWithImpl<$Res, TimelineEvent>;
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      String eventType,
      String description,
      String? metadata});
}

/// @nodoc
class _$TimelineEventCopyWithImpl<$Res, $Val extends TimelineEvent>
    implements $TimelineEventCopyWith<$Res> {
  _$TimelineEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? eventType = null,
    Object? description = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimelineEventImplCopyWith<$Res>
    implements $TimelineEventCopyWith<$Res> {
  factory _$$TimelineEventImplCopyWith(
          _$TimelineEventImpl value, $Res Function(_$TimelineEventImpl) then) =
      __$$TimelineEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      String eventType,
      String description,
      String? metadata});
}

/// @nodoc
class __$$TimelineEventImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$TimelineEventImpl>
    implements _$$TimelineEventImplCopyWith<$Res> {
  __$$TimelineEventImplCopyWithImpl(
      _$TimelineEventImpl _value, $Res Function(_$TimelineEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? eventType = null,
    Object? description = null,
    Object? metadata = freezed,
  }) {
    return _then(_$TimelineEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimelineEventImpl implements _TimelineEvent {
  const _$TimelineEventImpl(
      {required this.id,
      required this.timestamp,
      required this.eventType,
      required this.description,
      required this.metadata});

  factory _$TimelineEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimelineEventImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime timestamp;
  @override
  final String eventType;
  @override
  final String description;
  @override
  final String? metadata;

  @override
  String toString() {
    return 'TimelineEvent(id: $id, timestamp: $timestamp, eventType: $eventType, description: $description, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, timestamp, eventType, description, metadata);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineEventImplCopyWith<_$TimelineEventImpl> get copyWith =>
      __$$TimelineEventImplCopyWithImpl<_$TimelineEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimelineEventImplToJson(
      this,
    );
  }
}

abstract class _TimelineEvent implements TimelineEvent {
  const factory _TimelineEvent(
      {required final String id,
      required final DateTime timestamp,
      required final String eventType,
      required final String description,
      required final String? metadata}) = _$TimelineEventImpl;

  factory _TimelineEvent.fromJson(Map<String, dynamic> json) =
      _$TimelineEventImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get timestamp;
  @override
  String get eventType;
  @override
  String get description;
  @override
  String? get metadata;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimelineEventImplCopyWith<_$TimelineEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IncidentDetail _$IncidentDetailFromJson(Map<String, dynamic> json) {
  return _IncidentDetail.fromJson(json);
}

/// @nodoc
mixin _$IncidentDetail {
  Incident get incident => throw _privateConstructorUsedError;
  List<TimelineEvent> get timeline => throw _privateConstructorUsedError;
  Map<String, dynamic>? get analysisData => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;

  /// Serializes this IncidentDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IncidentDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IncidentDetailCopyWith<IncidentDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncidentDetailCopyWith<$Res> {
  factory $IncidentDetailCopyWith(
          IncidentDetail value, $Res Function(IncidentDetail) then) =
      _$IncidentDetailCopyWithImpl<$Res, IncidentDetail>;
  @useResult
  $Res call(
      {Incident incident,
      List<TimelineEvent> timeline,
      Map<String, dynamic>? analysisData,
      List<String> recommendations});

  $IncidentCopyWith<$Res> get incident;
}

/// @nodoc
class _$IncidentDetailCopyWithImpl<$Res, $Val extends IncidentDetail>
    implements $IncidentDetailCopyWith<$Res> {
  _$IncidentDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IncidentDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incident = null,
    Object? timeline = null,
    Object? analysisData = freezed,
    Object? recommendations = null,
  }) {
    return _then(_value.copyWith(
      incident: null == incident
          ? _value.incident
          : incident // ignore: cast_nullable_to_non_nullable
              as Incident,
      timeline: null == timeline
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as List<TimelineEvent>,
      analysisData: freezed == analysisData
          ? _value.analysisData
          : analysisData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  /// Create a copy of IncidentDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IncidentCopyWith<$Res> get incident {
    return $IncidentCopyWith<$Res>(_value.incident, (value) {
      return _then(_value.copyWith(incident: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IncidentDetailImplCopyWith<$Res>
    implements $IncidentDetailCopyWith<$Res> {
  factory _$$IncidentDetailImplCopyWith(_$IncidentDetailImpl value,
          $Res Function(_$IncidentDetailImpl) then) =
      __$$IncidentDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Incident incident,
      List<TimelineEvent> timeline,
      Map<String, dynamic>? analysisData,
      List<String> recommendations});

  @override
  $IncidentCopyWith<$Res> get incident;
}

/// @nodoc
class __$$IncidentDetailImplCopyWithImpl<$Res>
    extends _$IncidentDetailCopyWithImpl<$Res, _$IncidentDetailImpl>
    implements _$$IncidentDetailImplCopyWith<$Res> {
  __$$IncidentDetailImplCopyWithImpl(
      _$IncidentDetailImpl _value, $Res Function(_$IncidentDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of IncidentDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incident = null,
    Object? timeline = null,
    Object? analysisData = freezed,
    Object? recommendations = null,
  }) {
    return _then(_$IncidentDetailImpl(
      incident: null == incident
          ? _value.incident
          : incident // ignore: cast_nullable_to_non_nullable
              as Incident,
      timeline: null == timeline
          ? _value._timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as List<TimelineEvent>,
      analysisData: freezed == analysisData
          ? _value._analysisData
          : analysisData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IncidentDetailImpl implements _IncidentDetail {
  const _$IncidentDetailImpl(
      {required this.incident,
      required final List<TimelineEvent> timeline,
      required final Map<String, dynamic>? analysisData,
      required final List<String> recommendations})
      : _timeline = timeline,
        _analysisData = analysisData,
        _recommendations = recommendations;

  factory _$IncidentDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncidentDetailImplFromJson(json);

  @override
  final Incident incident;
  final List<TimelineEvent> _timeline;
  @override
  List<TimelineEvent> get timeline {
    if (_timeline is EqualUnmodifiableListView) return _timeline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeline);
  }

  final Map<String, dynamic>? _analysisData;
  @override
  Map<String, dynamic>? get analysisData {
    final value = _analysisData;
    if (value == null) return null;
    if (_analysisData is EqualUnmodifiableMapView) return _analysisData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String> _recommendations;
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  String toString() {
    return 'IncidentDetail(incident: $incident, timeline: $timeline, analysisData: $analysisData, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncidentDetailImpl &&
            (identical(other.incident, incident) ||
                other.incident == incident) &&
            const DeepCollectionEquality().equals(other._timeline, _timeline) &&
            const DeepCollectionEquality()
                .equals(other._analysisData, _analysisData) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      incident,
      const DeepCollectionEquality().hash(_timeline),
      const DeepCollectionEquality().hash(_analysisData),
      const DeepCollectionEquality().hash(_recommendations));

  /// Create a copy of IncidentDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncidentDetailImplCopyWith<_$IncidentDetailImpl> get copyWith =>
      __$$IncidentDetailImplCopyWithImpl<_$IncidentDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncidentDetailImplToJson(
      this,
    );
  }
}

abstract class _IncidentDetail implements IncidentDetail {
  const factory _IncidentDetail(
      {required final Incident incident,
      required final List<TimelineEvent> timeline,
      required final Map<String, dynamic>? analysisData,
      required final List<String> recommendations}) = _$IncidentDetailImpl;

  factory _IncidentDetail.fromJson(Map<String, dynamic> json) =
      _$IncidentDetailImpl.fromJson;

  @override
  Incident get incident;
  @override
  List<TimelineEvent> get timeline;
  @override
  Map<String, dynamic>? get analysisData;
  @override
  List<String> get recommendations;

  /// Create a copy of IncidentDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncidentDetailImplCopyWith<_$IncidentDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
