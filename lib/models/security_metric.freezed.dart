// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_metric.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SecurityMetric _$SecurityMetricFromJson(Map<String, dynamic> json) {
  return _SecurityMetric.fromJson(json);
}

/// @nodoc
mixin _$SecurityMetric {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;
  int? get threshold => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get trend => throw _privateConstructorUsedError; // up, down, stable
  String get category => throw _privateConstructorUsedError;

  /// Serializes this SecurityMetric to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SecurityMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecurityMetricCopyWith<SecurityMetric> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityMetricCopyWith<$Res> {
  factory $SecurityMetricCopyWith(
          SecurityMetric value, $Res Function(SecurityMetric) then) =
      _$SecurityMetricCopyWithImpl<$Res, SecurityMetric>;
  @useResult
  $Res call(
      {String id,
      String name,
      int value,
      int? threshold,
      String unit,
      DateTime timestamp,
      String trend,
      String category});
}

/// @nodoc
class _$SecurityMetricCopyWithImpl<$Res, $Val extends SecurityMetric>
    implements $SecurityMetricCopyWith<$Res> {
  _$SecurityMetricCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecurityMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? value = null,
    Object? threshold = freezed,
    Object? unit = null,
    Object? timestamp = null,
    Object? trend = null,
    Object? category = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      threshold: freezed == threshold
          ? _value.threshold
          : threshold // ignore: cast_nullable_to_non_nullable
              as int?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SecurityMetricImplCopyWith<$Res>
    implements $SecurityMetricCopyWith<$Res> {
  factory _$$SecurityMetricImplCopyWith(_$SecurityMetricImpl value,
          $Res Function(_$SecurityMetricImpl) then) =
      __$$SecurityMetricImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int value,
      int? threshold,
      String unit,
      DateTime timestamp,
      String trend,
      String category});
}

/// @nodoc
class __$$SecurityMetricImplCopyWithImpl<$Res>
    extends _$SecurityMetricCopyWithImpl<$Res, _$SecurityMetricImpl>
    implements _$$SecurityMetricImplCopyWith<$Res> {
  __$$SecurityMetricImplCopyWithImpl(
      _$SecurityMetricImpl _value, $Res Function(_$SecurityMetricImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? value = null,
    Object? threshold = freezed,
    Object? unit = null,
    Object? timestamp = null,
    Object? trend = null,
    Object? category = null,
  }) {
    return _then(_$SecurityMetricImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      threshold: freezed == threshold
          ? _value.threshold
          : threshold // ignore: cast_nullable_to_non_nullable
              as int?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SecurityMetricImpl implements _SecurityMetric {
  const _$SecurityMetricImpl(
      {required this.id,
      required this.name,
      required this.value,
      required this.threshold,
      required this.unit,
      required this.timestamp,
      required this.trend,
      required this.category});

  factory _$SecurityMetricImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecurityMetricImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int value;
  @override
  final int? threshold;
  @override
  final String unit;
  @override
  final DateTime timestamp;
  @override
  final String trend;
// up, down, stable
  @override
  final String category;

  @override
  String toString() {
    return 'SecurityMetric(id: $id, name: $name, value: $value, threshold: $threshold, unit: $unit, timestamp: $timestamp, trend: $trend, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityMetricImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.threshold, threshold) ||
                other.threshold == threshold) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.trend, trend) || other.trend == trend) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, value, threshold, unit,
      timestamp, trend, category);

  /// Create a copy of SecurityMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecurityMetricImplCopyWith<_$SecurityMetricImpl> get copyWith =>
      __$$SecurityMetricImplCopyWithImpl<_$SecurityMetricImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecurityMetricImplToJson(
      this,
    );
  }
}

abstract class _SecurityMetric implements SecurityMetric {
  const factory _SecurityMetric(
      {required final String id,
      required final String name,
      required final int value,
      required final int? threshold,
      required final String unit,
      required final DateTime timestamp,
      required final String trend,
      required final String category}) = _$SecurityMetricImpl;

  factory _SecurityMetric.fromJson(Map<String, dynamic> json) =
      _$SecurityMetricImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get value;
  @override
  int? get threshold;
  @override
  String get unit;
  @override
  DateTime get timestamp;
  @override
  String get trend; // up, down, stable
  @override
  String get category;

  /// Create a copy of SecurityMetric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecurityMetricImplCopyWith<_$SecurityMetricImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardMetrics _$DashboardMetricsFromJson(Map<String, dynamic> json) {
  return _DashboardMetrics.fromJson(json);
}

/// @nodoc
mixin _$DashboardMetrics {
  int get activeAlerts => throw _privateConstructorUsedError;
  int get openIncidents => throw _privateConstructorUsedError;
  int get threatsBlocked => throw _privateConstructorUsedError;
  double get systemHealth => throw _privateConstructorUsedError;
  List<SecurityMetric> get metrics => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this DashboardMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardMetricsCopyWith<DashboardMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardMetricsCopyWith<$Res> {
  factory $DashboardMetricsCopyWith(
          DashboardMetrics value, $Res Function(DashboardMetrics) then) =
      _$DashboardMetricsCopyWithImpl<$Res, DashboardMetrics>;
  @useResult
  $Res call(
      {int activeAlerts,
      int openIncidents,
      int threatsBlocked,
      double systemHealth,
      List<SecurityMetric> metrics,
      DateTime lastUpdated});
}

/// @nodoc
class _$DashboardMetricsCopyWithImpl<$Res, $Val extends DashboardMetrics>
    implements $DashboardMetricsCopyWith<$Res> {
  _$DashboardMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeAlerts = null,
    Object? openIncidents = null,
    Object? threatsBlocked = null,
    Object? systemHealth = null,
    Object? metrics = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      activeAlerts: null == activeAlerts
          ? _value.activeAlerts
          : activeAlerts // ignore: cast_nullable_to_non_nullable
              as int,
      openIncidents: null == openIncidents
          ? _value.openIncidents
          : openIncidents // ignore: cast_nullable_to_non_nullable
              as int,
      threatsBlocked: null == threatsBlocked
          ? _value.threatsBlocked
          : threatsBlocked // ignore: cast_nullable_to_non_nullable
              as int,
      systemHealth: null == systemHealth
          ? _value.systemHealth
          : systemHealth // ignore: cast_nullable_to_non_nullable
              as double,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as List<SecurityMetric>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardMetricsImplCopyWith<$Res>
    implements $DashboardMetricsCopyWith<$Res> {
  factory _$$DashboardMetricsImplCopyWith(_$DashboardMetricsImpl value,
          $Res Function(_$DashboardMetricsImpl) then) =
      __$$DashboardMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int activeAlerts,
      int openIncidents,
      int threatsBlocked,
      double systemHealth,
      List<SecurityMetric> metrics,
      DateTime lastUpdated});
}

/// @nodoc
class __$$DashboardMetricsImplCopyWithImpl<$Res>
    extends _$DashboardMetricsCopyWithImpl<$Res, _$DashboardMetricsImpl>
    implements _$$DashboardMetricsImplCopyWith<$Res> {
  __$$DashboardMetricsImplCopyWithImpl(_$DashboardMetricsImpl _value,
      $Res Function(_$DashboardMetricsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeAlerts = null,
    Object? openIncidents = null,
    Object? threatsBlocked = null,
    Object? systemHealth = null,
    Object? metrics = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$DashboardMetricsImpl(
      activeAlerts: null == activeAlerts
          ? _value.activeAlerts
          : activeAlerts // ignore: cast_nullable_to_non_nullable
              as int,
      openIncidents: null == openIncidents
          ? _value.openIncidents
          : openIncidents // ignore: cast_nullable_to_non_nullable
              as int,
      threatsBlocked: null == threatsBlocked
          ? _value.threatsBlocked
          : threatsBlocked // ignore: cast_nullable_to_non_nullable
              as int,
      systemHealth: null == systemHealth
          ? _value.systemHealth
          : systemHealth // ignore: cast_nullable_to_non_nullable
              as double,
      metrics: null == metrics
          ? _value._metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as List<SecurityMetric>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardMetricsImpl implements _DashboardMetrics {
  const _$DashboardMetricsImpl(
      {required this.activeAlerts,
      required this.openIncidents,
      required this.threatsBlocked,
      required this.systemHealth,
      required final List<SecurityMetric> metrics,
      required this.lastUpdated})
      : _metrics = metrics;

  factory _$DashboardMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardMetricsImplFromJson(json);

  @override
  final int activeAlerts;
  @override
  final int openIncidents;
  @override
  final int threatsBlocked;
  @override
  final double systemHealth;
  final List<SecurityMetric> _metrics;
  @override
  List<SecurityMetric> get metrics {
    if (_metrics is EqualUnmodifiableListView) return _metrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_metrics);
  }

  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'DashboardMetrics(activeAlerts: $activeAlerts, openIncidents: $openIncidents, threatsBlocked: $threatsBlocked, systemHealth: $systemHealth, metrics: $metrics, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardMetricsImpl &&
            (identical(other.activeAlerts, activeAlerts) ||
                other.activeAlerts == activeAlerts) &&
            (identical(other.openIncidents, openIncidents) ||
                other.openIncidents == openIncidents) &&
            (identical(other.threatsBlocked, threatsBlocked) ||
                other.threatsBlocked == threatsBlocked) &&
            (identical(other.systemHealth, systemHealth) ||
                other.systemHealth == systemHealth) &&
            const DeepCollectionEquality().equals(other._metrics, _metrics) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      activeAlerts,
      openIncidents,
      threatsBlocked,
      systemHealth,
      const DeepCollectionEquality().hash(_metrics),
      lastUpdated);

  /// Create a copy of DashboardMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardMetricsImplCopyWith<_$DashboardMetricsImpl> get copyWith =>
      __$$DashboardMetricsImplCopyWithImpl<_$DashboardMetricsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardMetricsImplToJson(
      this,
    );
  }
}

abstract class _DashboardMetrics implements DashboardMetrics {
  const factory _DashboardMetrics(
      {required final int activeAlerts,
      required final int openIncidents,
      required final int threatsBlocked,
      required final double systemHealth,
      required final List<SecurityMetric> metrics,
      required final DateTime lastUpdated}) = _$DashboardMetricsImpl;

  factory _DashboardMetrics.fromJson(Map<String, dynamic> json) =
      _$DashboardMetricsImpl.fromJson;

  @override
  int get activeAlerts;
  @override
  int get openIncidents;
  @override
  int get threatsBlocked;
  @override
  double get systemHealth;
  @override
  List<SecurityMetric> get metrics;
  @override
  DateTime get lastUpdated;

  /// Create a copy of DashboardMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardMetricsImplCopyWith<_$DashboardMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
