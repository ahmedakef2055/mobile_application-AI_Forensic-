// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Alert _$AlertFromJson(Map<String, dynamic> json) {
  return _Alert.fromJson(json);
}

/// @nodoc
mixin _$Alert {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Severity get severity => throw _privateConstructorUsedError;
  String get alertType =>
      throw _privateConstructorUsedError; // intrusion, malware, policy_violation, etc
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get sourceIp => throw _privateConstructorUsedError;
  String? get affectedSystem => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  String? get actionUrl => throw _privateConstructorUsedError;

  /// Serializes this Alert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertCopyWith<Alert> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertCopyWith<$Res> {
  factory $AlertCopyWith(Alert value, $Res Function(Alert) then) =
      _$AlertCopyWithImpl<$Res, Alert>;
  @useResult
  $Res call(
      {String id,
      String title,
      String message,
      Severity severity,
      String alertType,
      DateTime timestamp,
      String sourceIp,
      String? affectedSystem,
      bool isRead,
      String? actionUrl});
}

/// @nodoc
class _$AlertCopyWithImpl<$Res, $Val extends Alert>
    implements $AlertCopyWith<$Res> {
  _$AlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? message = null,
    Object? severity = null,
    Object? alertType = null,
    Object? timestamp = null,
    Object? sourceIp = null,
    Object? affectedSystem = freezed,
    Object? isRead = null,
    Object? actionUrl = freezed,
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
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as Severity,
      alertType: null == alertType
          ? _value.alertType
          : alertType // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sourceIp: null == sourceIp
          ? _value.sourceIp
          : sourceIp // ignore: cast_nullable_to_non_nullable
              as String,
      affectedSystem: freezed == affectedSystem
          ? _value.affectedSystem
          : affectedSystem // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      actionUrl: freezed == actionUrl
          ? _value.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlertImplCopyWith<$Res> implements $AlertCopyWith<$Res> {
  factory _$$AlertImplCopyWith(
          _$AlertImpl value, $Res Function(_$AlertImpl) then) =
      __$$AlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String message,
      Severity severity,
      String alertType,
      DateTime timestamp,
      String sourceIp,
      String? affectedSystem,
      bool isRead,
      String? actionUrl});
}

/// @nodoc
class __$$AlertImplCopyWithImpl<$Res>
    extends _$AlertCopyWithImpl<$Res, _$AlertImpl>
    implements _$$AlertImplCopyWith<$Res> {
  __$$AlertImplCopyWithImpl(
      _$AlertImpl _value, $Res Function(_$AlertImpl) _then)
      : super(_value, _then);

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? message = null,
    Object? severity = null,
    Object? alertType = null,
    Object? timestamp = null,
    Object? sourceIp = null,
    Object? affectedSystem = freezed,
    Object? isRead = null,
    Object? actionUrl = freezed,
  }) {
    return _then(_$AlertImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as Severity,
      alertType: null == alertType
          ? _value.alertType
          : alertType // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sourceIp: null == sourceIp
          ? _value.sourceIp
          : sourceIp // ignore: cast_nullable_to_non_nullable
              as String,
      affectedSystem: freezed == affectedSystem
          ? _value.affectedSystem
          : affectedSystem // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      actionUrl: freezed == actionUrl
          ? _value.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlertImpl implements _Alert {
  const _$AlertImpl(
      {required this.id,
      required this.title,
      required this.message,
      required this.severity,
      required this.alertType,
      required this.timestamp,
      required this.sourceIp,
      required this.affectedSystem,
      required this.isRead,
      required this.actionUrl});

  factory _$AlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String message;
  @override
  final Severity severity;
  @override
  final String alertType;
// intrusion, malware, policy_violation, etc
  @override
  final DateTime timestamp;
  @override
  final String sourceIp;
  @override
  final String? affectedSystem;
  @override
  final bool isRead;
  @override
  final String? actionUrl;

  @override
  String toString() {
    return 'Alert(id: $id, title: $title, message: $message, severity: $severity, alertType: $alertType, timestamp: $timestamp, sourceIp: $sourceIp, affectedSystem: $affectedSystem, isRead: $isRead, actionUrl: $actionUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.alertType, alertType) ||
                other.alertType == alertType) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.sourceIp, sourceIp) ||
                other.sourceIp == sourceIp) &&
            (identical(other.affectedSystem, affectedSystem) ||
                other.affectedSystem == affectedSystem) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.actionUrl, actionUrl) ||
                other.actionUrl == actionUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, message, severity,
      alertType, timestamp, sourceIp, affectedSystem, isRead, actionUrl);

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertImplCopyWith<_$AlertImpl> get copyWith =>
      __$$AlertImplCopyWithImpl<_$AlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertImplToJson(
      this,
    );
  }
}

abstract class _Alert implements Alert {
  const factory _Alert(
      {required final String id,
      required final String title,
      required final String message,
      required final Severity severity,
      required final String alertType,
      required final DateTime timestamp,
      required final String sourceIp,
      required final String? affectedSystem,
      required final bool isRead,
      required final String? actionUrl}) = _$AlertImpl;

  factory _Alert.fromJson(Map<String, dynamic> json) = _$AlertImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get message;
  @override
  Severity get severity;
  @override
  String get alertType; // intrusion, malware, policy_violation, etc
  @override
  DateTime get timestamp;
  @override
  String get sourceIp;
  @override
  String? get affectedSystem;
  @override
  bool get isRead;
  @override
  String? get actionUrl;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertImplCopyWith<_$AlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
