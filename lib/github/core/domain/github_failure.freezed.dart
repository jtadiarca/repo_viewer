// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'github_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GithubFailureTearOff {
  const _$GithubFailureTearOff();

  _Api api(HttpStatus httpStatus) {
    return _Api(
      httpStatus,
    );
  }
}

/// @nodoc
const $GithubFailure = _$GithubFailureTearOff();

/// @nodoc
mixin _$GithubFailure {
  HttpStatus get httpStatus => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(HttpStatus httpStatus) api,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(HttpStatus httpStatus)? api,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Api value) api,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Api value)? api,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GithubFailureCopyWith<GithubFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GithubFailureCopyWith<$Res> {
  factory $GithubFailureCopyWith(
          GithubFailure value, $Res Function(GithubFailure) then) =
      _$GithubFailureCopyWithImpl<$Res>;
  $Res call({HttpStatus httpStatus});
}

/// @nodoc
class _$GithubFailureCopyWithImpl<$Res>
    implements $GithubFailureCopyWith<$Res> {
  _$GithubFailureCopyWithImpl(this._value, this._then);

  final GithubFailure _value;
  // ignore: unused_field
  final $Res Function(GithubFailure) _then;

  @override
  $Res call({
    Object? httpStatus = freezed,
  }) {
    return _then(_value.copyWith(
      httpStatus: httpStatus == freezed
          ? _value.httpStatus
          : httpStatus // ignore: cast_nullable_to_non_nullable
              as HttpStatus,
    ));
  }
}

/// @nodoc
abstract class _$ApiCopyWith<$Res> implements $GithubFailureCopyWith<$Res> {
  factory _$ApiCopyWith(_Api value, $Res Function(_Api) then) =
      __$ApiCopyWithImpl<$Res>;
  @override
  $Res call({HttpStatus httpStatus});
}

/// @nodoc
class __$ApiCopyWithImpl<$Res> extends _$GithubFailureCopyWithImpl<$Res>
    implements _$ApiCopyWith<$Res> {
  __$ApiCopyWithImpl(_Api _value, $Res Function(_Api) _then)
      : super(_value, (v) => _then(v as _Api));

  @override
  _Api get _value => super._value as _Api;

  @override
  $Res call({
    Object? httpStatus = freezed,
  }) {
    return _then(_Api(
      httpStatus == freezed
          ? _value.httpStatus
          : httpStatus // ignore: cast_nullable_to_non_nullable
              as HttpStatus,
    ));
  }
}

/// @nodoc

class _$_Api extends _Api {
  const _$_Api(this.httpStatus) : super._();

  @override
  final HttpStatus httpStatus;

  @override
  String toString() {
    return 'GithubFailure.api(httpStatus: $httpStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Api &&
            (identical(other.httpStatus, httpStatus) ||
                const DeepCollectionEquality()
                    .equals(other.httpStatus, httpStatus)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(httpStatus);

  @JsonKey(ignore: true)
  @override
  _$ApiCopyWith<_Api> get copyWith =>
      __$ApiCopyWithImpl<_Api>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(HttpStatus httpStatus) api,
  }) {
    return api(httpStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(HttpStatus httpStatus)? api,
    required TResult orElse(),
  }) {
    if (api != null) {
      return api(httpStatus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Api value) api,
  }) {
    return api(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Api value)? api,
    required TResult orElse(),
  }) {
    if (api != null) {
      return api(this);
    }
    return orElse();
  }
}

abstract class _Api extends GithubFailure {
  const factory _Api(HttpStatus httpStatus) = _$_Api;
  const _Api._() : super._();

  @override
  HttpStatus get httpStatus => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ApiCopyWith<_Api> get copyWith => throw _privateConstructorUsedError;
}
