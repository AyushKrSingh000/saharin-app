// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_tab_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeTabPageState {
  String get errorMessage => throw _privateConstructorUsedError;
  List<InsurancePlanData> get insuranceData =>
      throw _privateConstructorUsedError;
  List<InsuranceProviderData> get insuranceProviders =>
      throw _privateConstructorUsedError;
  HomePageStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeTabPageStateCopyWith<HomeTabPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeTabPageStateCopyWith<$Res> {
  factory $HomeTabPageStateCopyWith(
          HomeTabPageState value, $Res Function(HomeTabPageState) then) =
      _$HomeTabPageStateCopyWithImpl<$Res, HomeTabPageState>;
  @useResult
  $Res call(
      {String errorMessage,
      List<InsurancePlanData> insuranceData,
      List<InsuranceProviderData> insuranceProviders,
      HomePageStatus status});
}

/// @nodoc
class _$HomeTabPageStateCopyWithImpl<$Res, $Val extends HomeTabPageState>
    implements $HomeTabPageStateCopyWith<$Res> {
  _$HomeTabPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
    Object? insuranceData = null,
    Object? insuranceProviders = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      insuranceData: null == insuranceData
          ? _value.insuranceData
          : insuranceData // ignore: cast_nullable_to_non_nullable
              as List<InsurancePlanData>,
      insuranceProviders: null == insuranceProviders
          ? _value.insuranceProviders
          : insuranceProviders // ignore: cast_nullable_to_non_nullable
              as List<InsuranceProviderData>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as HomePageStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeTabPageStateImplCopyWith<$Res>
    implements $HomeTabPageStateCopyWith<$Res> {
  factory _$$HomeTabPageStateImplCopyWith(_$HomeTabPageStateImpl value,
          $Res Function(_$HomeTabPageStateImpl) then) =
      __$$HomeTabPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String errorMessage,
      List<InsurancePlanData> insuranceData,
      List<InsuranceProviderData> insuranceProviders,
      HomePageStatus status});
}

/// @nodoc
class __$$HomeTabPageStateImplCopyWithImpl<$Res>
    extends _$HomeTabPageStateCopyWithImpl<$Res, _$HomeTabPageStateImpl>
    implements _$$HomeTabPageStateImplCopyWith<$Res> {
  __$$HomeTabPageStateImplCopyWithImpl(_$HomeTabPageStateImpl _value,
      $Res Function(_$HomeTabPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
    Object? insuranceData = null,
    Object? insuranceProviders = null,
    Object? status = null,
  }) {
    return _then(_$HomeTabPageStateImpl(
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      insuranceData: null == insuranceData
          ? _value._insuranceData
          : insuranceData // ignore: cast_nullable_to_non_nullable
              as List<InsurancePlanData>,
      insuranceProviders: null == insuranceProviders
          ? _value._insuranceProviders
          : insuranceProviders // ignore: cast_nullable_to_non_nullable
              as List<InsuranceProviderData>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as HomePageStatus,
    ));
  }
}

/// @nodoc

class _$HomeTabPageStateImpl implements _HomeTabPageState {
  const _$HomeTabPageStateImpl(
      {this.errorMessage = '',
      final List<InsurancePlanData> insuranceData = const [],
      final List<InsuranceProviderData> insuranceProviders = const [],
      this.status = HomePageStatus.initial})
      : _insuranceData = insuranceData,
        _insuranceProviders = insuranceProviders;

  @override
  @JsonKey()
  final String errorMessage;
  final List<InsurancePlanData> _insuranceData;
  @override
  @JsonKey()
  List<InsurancePlanData> get insuranceData {
    if (_insuranceData is EqualUnmodifiableListView) return _insuranceData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_insuranceData);
  }

  final List<InsuranceProviderData> _insuranceProviders;
  @override
  @JsonKey()
  List<InsuranceProviderData> get insuranceProviders {
    if (_insuranceProviders is EqualUnmodifiableListView)
      return _insuranceProviders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_insuranceProviders);
  }

  @override
  @JsonKey()
  final HomePageStatus status;

  @override
  String toString() {
    return 'HomeTabPageState(errorMessage: $errorMessage, insuranceData: $insuranceData, insuranceProviders: $insuranceProviders, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeTabPageStateImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other._insuranceData, _insuranceData) &&
            const DeepCollectionEquality()
                .equals(other._insuranceProviders, _insuranceProviders) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      errorMessage,
      const DeepCollectionEquality().hash(_insuranceData),
      const DeepCollectionEquality().hash(_insuranceProviders),
      status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeTabPageStateImplCopyWith<_$HomeTabPageStateImpl> get copyWith =>
      __$$HomeTabPageStateImplCopyWithImpl<_$HomeTabPageStateImpl>(
          this, _$identity);
}

abstract class _HomeTabPageState implements HomeTabPageState {
  const factory _HomeTabPageState(
      {final String errorMessage,
      final List<InsurancePlanData> insuranceData,
      final List<InsuranceProviderData> insuranceProviders,
      final HomePageStatus status}) = _$HomeTabPageStateImpl;

  @override
  String get errorMessage;
  @override
  List<InsurancePlanData> get insuranceData;
  @override
  List<InsuranceProviderData> get insuranceProviders;
  @override
  HomePageStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$HomeTabPageStateImplCopyWith<_$HomeTabPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
