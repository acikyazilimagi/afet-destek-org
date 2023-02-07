// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demand_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DemandCategory _$DemandCategoryFromJson(Map<String, dynamic> json) {
  return _DemandCategory.fromJson(json);
}

/// @nodoc
mixin _$DemandCategory {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DemandCategoryCopyWith<DemandCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemandCategoryCopyWith<$Res> {
  factory $DemandCategoryCopyWith(
          DemandCategory value, $Res Function(DemandCategory) then) =
      _$DemandCategoryCopyWithImpl<$Res, DemandCategory>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$DemandCategoryCopyWithImpl<$Res, $Val extends DemandCategory>
    implements $DemandCategoryCopyWith<$Res> {
  _$DemandCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DemandCategoryCopyWith<$Res>
    implements $DemandCategoryCopyWith<$Res> {
  factory _$$_DemandCategoryCopyWith(
          _$_DemandCategory value, $Res Function(_$_DemandCategory) then) =
      __$$_DemandCategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$_DemandCategoryCopyWithImpl<$Res>
    extends _$DemandCategoryCopyWithImpl<$Res, _$_DemandCategory>
    implements _$$_DemandCategoryCopyWith<$Res> {
  __$$_DemandCategoryCopyWithImpl(
      _$_DemandCategory _value, $Res Function(_$_DemandCategory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$_DemandCategory(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DemandCategory
    with DiagnosticableTreeMixin
    implements _DemandCategory {
  const _$_DemandCategory({required this.id, required this.name});

  factory _$_DemandCategory.fromJson(Map<String, dynamic> json) =>
      _$$_DemandCategoryFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DemandCategory(id: $id, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DemandCategory'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DemandCategory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DemandCategoryCopyWith<_$_DemandCategory> get copyWith =>
      __$$_DemandCategoryCopyWithImpl<_$_DemandCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DemandCategoryToJson(
      this,
    );
  }
}

abstract class _DemandCategory implements DemandCategory {
  const factory _DemandCategory(
      {required final String id,
      required final String name}) = _$_DemandCategory;

  factory _DemandCategory.fromJson(Map<String, dynamic> json) =
      _$_DemandCategory.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_DemandCategoryCopyWith<_$_DemandCategory> get copyWith =>
      throw _privateConstructorUsedError;
}
