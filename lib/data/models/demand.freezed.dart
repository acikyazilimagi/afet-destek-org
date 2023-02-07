// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demand.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Demand _$DemandFromJson(Map<String, dynamic> json) {
  return _Demand.fromJson(json);
}

/// @nodoc
mixin _$Demand {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  List<String> get categoryIds => throw _privateConstructorUsedError;
  GeoFirePoint get geo => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DemandCopyWith<Demand> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemandCopyWith<$Res> {
  factory $DemandCopyWith(Demand value, $Res Function(Demand) then) =
      _$DemandCopyWithImpl<$Res, Demand>;
  @useResult
  $Res call(
      {String id,
      String userId,
      List<String> categoryIds,
      GeoFirePoint geo,
      String notes,
      String phoneNumber,
      bool isActive});
}

/// @nodoc
class _$DemandCopyWithImpl<$Res, $Val extends Demand>
    implements $DemandCopyWith<$Res> {
  _$DemandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? categoryIds = null,
    Object? geo = null,
    Object? notes = null,
    Object? phoneNumber = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryIds: null == categoryIds
          ? _value.categoryIds
          : categoryIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      geo: null == geo
          ? _value.geo
          : geo // ignore: cast_nullable_to_non_nullable
              as GeoFirePoint,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DemandCopyWith<$Res> implements $DemandCopyWith<$Res> {
  factory _$$_DemandCopyWith(_$_Demand value, $Res Function(_$_Demand) then) =
      __$$_DemandCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      List<String> categoryIds,
      GeoFirePoint geo,
      String notes,
      String phoneNumber,
      bool isActive});
}

/// @nodoc
class __$$_DemandCopyWithImpl<$Res>
    extends _$DemandCopyWithImpl<$Res, _$_Demand>
    implements _$$_DemandCopyWith<$Res> {
  __$$_DemandCopyWithImpl(_$_Demand _value, $Res Function(_$_Demand) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? categoryIds = null,
    Object? geo = null,
    Object? notes = null,
    Object? phoneNumber = null,
    Object? isActive = null,
  }) {
    return _then(_$_Demand(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryIds: null == categoryIds
          ? _value._categoryIds
          : categoryIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      geo: null == geo
          ? _value.geo
          : geo // ignore: cast_nullable_to_non_nullable
              as GeoFirePoint,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Demand with DiagnosticableTreeMixin implements _Demand {
  const _$_Demand(
      {required this.id,
      required this.userId,
      required final List<String> categoryIds,
      required this.geo,
      required this.notes,
      required this.phoneNumber,
      required this.isActive})
      : _categoryIds = categoryIds;

  factory _$_Demand.fromJson(Map<String, dynamic> json) =>
      _$$_DemandFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  final List<String> _categoryIds;
  @override
  List<String> get categoryIds {
    if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryIds);
  }

  @override
  final GeoFirePoint geo;
  @override
  final String notes;
  @override
  final String phoneNumber;
  @override
  final bool isActive;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Demand(id: $id, userId: $userId, categoryIds: $categoryIds, geo: $geo, notes: $notes, phoneNumber: $phoneNumber, isActive: $isActive)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Demand'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('categoryIds', categoryIds))
      ..add(DiagnosticsProperty('geo', geo))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('isActive', isActive));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Demand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other._categoryIds, _categoryIds) &&
            (identical(other.geo, geo) || other.geo == geo) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      const DeepCollectionEquality().hash(_categoryIds),
      geo,
      notes,
      phoneNumber,
      isActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DemandCopyWith<_$_Demand> get copyWith =>
      __$$_DemandCopyWithImpl<_$_Demand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DemandToJson(
      this,
    );
  }
}

abstract class _Demand implements Demand {
  const factory _Demand(
      {required final String id,
      required final String userId,
      required final List<String> categoryIds,
      required final GeoFirePoint geo,
      required final String notes,
      required final String phoneNumber,
      required final bool isActive}) = _$_Demand;

  factory _Demand.fromJson(Map<String, dynamic> json) = _$_Demand.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  List<String> get categoryIds;
  @override
  GeoFirePoint get geo;
  @override
  String get notes;
  @override
  String get phoneNumber;
  @override
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$$_DemandCopyWith<_$_Demand> get copyWith =>
      throw _privateConstructorUsedError;
}
