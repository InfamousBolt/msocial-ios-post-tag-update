// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'upload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UploadStateTearOff {
  const _$UploadStateTearOff();

  _UploadInitial initial() {
    return const _UploadInitial();
  }

  _UploadPicked picked(FileModel file) {
    return _UploadPicked(
      file,
    );
  }

  _Uploading uploading(double progress) {
    return _Uploading(
      progress,
    );
  }

  _UploadSuccess success(FileModel file) {
    return _UploadSuccess(
      file,
    );
  }

  _UploadFailed failed(String msg) {
    return _UploadFailed(
      msg,
    );
  }
}

/// @nodoc
const $UploadState = _$UploadStateTearOff();

/// @nodoc
mixin _$UploadState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(FileModel file) picked,
    required TResult Function(double progress) uploading,
    required TResult Function(FileModel file) success,
    required TResult Function(String msg) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(FileModel file)? picked,
    TResult Function(double progress)? uploading,
    TResult Function(FileModel file)? success,
    TResult Function(String msg)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(FileModel file)? picked,
    TResult Function(double progress)? uploading,
    TResult Function(FileModel file)? success,
    TResult Function(String msg)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadInitial value) initial,
    required TResult Function(_UploadPicked value) picked,
    required TResult Function(_Uploading value) uploading,
    required TResult Function(_UploadSuccess value) success,
    required TResult Function(_UploadFailed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UploadInitial value)? initial,
    TResult Function(_UploadPicked value)? picked,
    TResult Function(_Uploading value)? uploading,
    TResult Function(_UploadSuccess value)? success,
    TResult Function(_UploadFailed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadInitial value)? initial,
    TResult Function(_UploadPicked value)? picked,
    TResult Function(_Uploading value)? uploading,
    TResult Function(_UploadSuccess value)? success,
    TResult Function(_UploadFailed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadStateCopyWith<$Res> {
  factory $UploadStateCopyWith(
          UploadState value, $Res Function(UploadState) then) =
      _$UploadStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$UploadStateCopyWithImpl<$Res> implements $UploadStateCopyWith<$Res> {
  _$UploadStateCopyWithImpl(this._value, this._then);

  final UploadState _value;
  // ignore: unused_field
  final $Res Function(UploadState) _then;
}

/// @nodoc
abstract class _$UploadInitialCopyWith<$Res> {
  factory _$UploadInitialCopyWith(
          _UploadInitial value, $Res Function(_UploadInitial) then) =
      __$UploadInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$UploadInitialCopyWithImpl<$Res> extends _$UploadStateCopyWithImpl<$Res>
    implements _$UploadInitialCopyWith<$Res> {
  __$UploadInitialCopyWithImpl(
      _UploadInitial _value, $Res Function(_UploadInitial) _then)
      : super(_value, (v) => _then(v as _UploadInitial));

  @override
  _UploadInitial get _value => super._value as _UploadInitial;
}

/// @nodoc

class _$_UploadInitial implements _UploadInitial {
  const _$_UploadInitial();

  @override
  String toString() {
    return 'UploadState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _UploadInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(FileModel file) picked,
    required TResult Function(double progress) uploading,
    required TResult Function(FileModel file) success,
    required TResult Function(String msg) failed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(FileModel file)? picked,
    TResult Function(double progress)? uploading,
    TResult Function(FileModel file)? success,
    TResult Function(String msg)? failed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(FileModel file)? picked,
    TResult Function(double progress)? uploading,
    TResult Function(FileModel file)? success,
    TResult Function(String msg)? failed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadInitial value) initial,
    required TResult Function(_UploadPicked value) picked,
    required TResult Function(_Uploading value) uploading,
    required TResult Function(_UploadSuccess value) success,
    required TResult Function(_UploadFailed value) failed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UploadInitial value)? initial,
    TResult Function(_UploadPicked value)? picked,
    TResult Function(_Uploading value)? uploading,
    TResult Function(_UploadSuccess value)? success,
    TResult Function(_UploadFailed value)? failed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadInitial value)? initial,
    TResult Function(_UploadPicked value)? picked,
    TResult Function(_Uploading value)? uploading,
    TResult Function(_UploadSuccess value)? success,
    TResult Function(_UploadFailed value)? failed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _UploadInitial implements UploadState {
  const factory _UploadInitial() = _$_UploadInitial;
}

/// @nodoc
abstract class _$UploadPickedCopyWith<$Res> {
  factory _$UploadPickedCopyWith(
          _UploadPicked value, $Res Function(_UploadPicked) then) =
      __$UploadPickedCopyWithImpl<$Res>;
  $Res call({FileModel file});
}

/// @nodoc
class __$UploadPickedCopyWithImpl<$Res> extends _$UploadStateCopyWithImpl<$Res>
    implements _$UploadPickedCopyWith<$Res> {
  __$UploadPickedCopyWithImpl(
      _UploadPicked _value, $Res Function(_UploadPicked) _then)
      : super(_value, (v) => _then(v as _UploadPicked));

  @override
  _UploadPicked get _value => super._value as _UploadPicked;

  @override
  $Res call({
    Object? file = freezed,
  }) {
    return _then(_UploadPicked(
      file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as FileModel,
    ));
  }
}

/// @nodoc

class _$_UploadPicked implements _UploadPicked {
  const _$_UploadPicked(this.file);

  @override
  final FileModel file;

  @override
  String toString() {
    return 'UploadState.picked(file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UploadPicked &&
            const DeepCollectionEquality().equals(other.file, file));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(file));

  @JsonKey(ignore: true)
  @override
  _$UploadPickedCopyWith<_UploadPicked> get copyWith =>
      __$UploadPickedCopyWithImpl<_UploadPicked>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(FileModel file) picked,
    required TResult Function(double progress) uploading,
    required TResult Function(FileModel file) success,
    required TResult Function(String msg) failed,
  }) {
    return picked(file);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(FileModel file)? picked,
    TResult Function(double progress)? uploading,
    TResult Function(FileModel file)? success,
    TResult Function(String msg)? failed,
  }) {
    return picked?.call(file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(FileModel file)? picked,
    TResult Function(double progress)? uploading,
    TResult Function(FileModel file)? success,
    TResult Function(String msg)? failed,
    required TResult orElse(),
  }) {
    if (picked != null) {
      return picked(file);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadInitial value) initial,
    required TResult Function(_UploadPicked value) picked,
    required TResult Function(_Uploading value) uploading,
    required TResult Function(_UploadSuccess value) success,
    required TResult Function(_UploadFailed value) failed,
  }) {
    return picked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UploadInitial value)? initial,
    TResult Function(_UploadPicked value)? picked,
    TResult Function(_Uploading value)? uploading,
    TResult Function(_UploadSuccess value)? success,
    TResult Function(_UploadFailed value)? failed,
  }) {
    return picked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadInitial value)? initial,
    TResult Function(_UploadPicked value)? picked,
    TResult Function(_Uploading value)? uploading,
    TResult Function(_UploadSuccess value)? success,
    TResult Function(_UploadFailed value)? failed,
    required TResult orElse(),
  }) {
    if (picked != null) {
      return picked(this);
    }
    return orElse();
  }
}

abstract class _UploadPicked implements UploadState {
  const factory _UploadPicked(FileModel file) = _$_UploadPicked;

  FileModel get file;
  @JsonKey(ignore: true)
  _$UploadPickedCopyWith<_UploadPicked> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UploadingCopyWith<$Res> {
  factory _$UploadingCopyWith(
          _Uploading value, $Res Function(_Uploading) then) =
      __$UploadingCopyWithImpl<$Res>;
  $Res call({double progress});
}

/// @nodoc
class __$UploadingCopyWithImpl<$Res> extends _$UploadStateCopyWithImpl<$Res>
    implements _$UploadingCopyWith<$Res> {
  __$UploadingCopyWithImpl(_Uploading _value, $Res Function(_Uploading) _then)
      : super(_value, (v) => _then(v as _Uploading));

  @override
  _Uploading get _value => super._value as _Uploading;

  @override
  $Res call({
    Object? progress = freezed,
  }) {
    return _then(_Uploading(
      progress == freezed
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_Uploading implements _Uploading {
  const _$_Uploading(this.progress);

  @override
  final double progress;

  @override
  String toString() {
    return 'UploadState.uploading(progress: $progress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Uploading &&
            const DeepCollectionEquality().equals(other.progress, progress));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(progress));

  @JsonKey(ignore: true)
  @override
  _$UploadingCopyWith<_Uploading> get copyWith =>
      __$UploadingCopyWithImpl<_Uploading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(FileModel file) picked,
    required TResult Function(double progress) uploading,
    required TResult Function(FileModel file) success,
    required TResult Function(String msg) failed,
  }) {
    return uploading(progress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(FileModel file)? picked,
    TResult Function(double progress)? uploading,
    TResult Function(FileModel file)? success,
    TResult Function(String msg)? failed,
  }) {
    return uploading?.call(progress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(FileModel file)? picked,
    TResult Function(double progress)? uploading,
    TResult Function(FileModel file)? success,
    TResult Function(String msg)? failed,
    required TResult orElse(),
  }) {
    if (uploading != null) {
      return uploading(progress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadInitial value) initial,
    required TResult Function(_UploadPicked value) picked,
    required TResult Function(_Uploading value) uploading,
    required TResult Function(_UploadSuccess value) success,
    required TResult Function(_UploadFailed value) failed,
  }) {
    return uploading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UploadInitial value)? initial,
    TResult Function(_UploadPicked value)? picked,
    TResult Function(_Uploading value)? uploading,
    TResult Function(_UploadSuccess value)? success,
    TResult Function(_UploadFailed value)? failed,
  }) {
    return uploading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadInitial value)? initial,
    TResult Function(_UploadPicked value)? picked,
    TResult Function(_Uploading value)? uploading,
    TResult Function(_UploadSuccess value)? success,
    TResult Function(_UploadFailed value)? failed,
    required TResult orElse(),
  }) {
    if (uploading != null) {
      return uploading(this);
    }
    return orElse();
  }
}

abstract class _Uploading implements UploadState {
  const factory _Uploading(double progress) = _$_Uploading;

  double get progress;
  @JsonKey(ignore: true)
  _$UploadingCopyWith<_Uploading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UploadSuccessCopyWith<$Res> {
  factory _$UploadSuccessCopyWith(
          _UploadSuccess value, $Res Function(_UploadSuccess) then) =
      __$UploadSuccessCopyWithImpl<$Res>;
  $Res call({FileModel file});
}

/// @nodoc
class __$UploadSuccessCopyWithImpl<$Res> extends _$UploadStateCopyWithImpl<$Res>
    implements _$UploadSuccessCopyWith<$Res> {
  __$UploadSuccessCopyWithImpl(
      _UploadSuccess _value, $Res Function(_UploadSuccess) _then)
      : super(_value, (v) => _then(v as _UploadSuccess));

  @override
  _UploadSuccess get _value => super._value as _UploadSuccess;

  @override
  $Res call({
    Object? file = freezed,
  }) {
    return _then(_UploadSuccess(
      file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as FileModel,
    ));
  }
}

/// @nodoc

class _$_UploadSuccess implements _UploadSuccess {
  const _$_UploadSuccess(this.file);

  @override
  final FileModel file;

  @override
  String toString() {
    return 'UploadState.success(file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UploadSuccess &&
            const DeepCollectionEquality().equals(other.file, file));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(file));

  @JsonKey(ignore: true)
  @override
  _$UploadSuccessCopyWith<_UploadSuccess> get copyWith =>
      __$UploadSuccessCopyWithImpl<_UploadSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(FileModel file) picked,
    required TResult Function(double progress) uploading,
    required TResult Function(FileModel file) success,
    required TResult Function(String msg) failed,
  }) {
    return success(file);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(FileModel file)? picked,
    TResult Function(double progress)? uploading,
    TResult Function(FileModel file)? success,
    TResult Function(String msg)? failed,
  }) {
    return success?.call(file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(FileModel file)? picked,
    TResult Function(double progress)? uploading,
    TResult Function(FileModel file)? success,
    TResult Function(String msg)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(file);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadInitial value) initial,
    required TResult Function(_UploadPicked value) picked,
    required TResult Function(_Uploading value) uploading,
    required TResult Function(_UploadSuccess value) success,
    required TResult Function(_UploadFailed value) failed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UploadInitial value)? initial,
    TResult Function(_UploadPicked value)? picked,
    TResult Function(_Uploading value)? uploading,
    TResult Function(_UploadSuccess value)? success,
    TResult Function(_UploadFailed value)? failed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadInitial value)? initial,
    TResult Function(_UploadPicked value)? picked,
    TResult Function(_Uploading value)? uploading,
    TResult Function(_UploadSuccess value)? success,
    TResult Function(_UploadFailed value)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _UploadSuccess implements UploadState {
  const factory _UploadSuccess(FileModel file) = _$_UploadSuccess;

  FileModel get file;
  @JsonKey(ignore: true)
  _$UploadSuccessCopyWith<_UploadSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UploadFailedCopyWith<$Res> {
  factory _$UploadFailedCopyWith(
          _UploadFailed value, $Res Function(_UploadFailed) then) =
      __$UploadFailedCopyWithImpl<$Res>;
  $Res call({String msg});
}

/// @nodoc
class __$UploadFailedCopyWithImpl<$Res> extends _$UploadStateCopyWithImpl<$Res>
    implements _$UploadFailedCopyWith<$Res> {
  __$UploadFailedCopyWithImpl(
      _UploadFailed _value, $Res Function(_UploadFailed) _then)
      : super(_value, (v) => _then(v as _UploadFailed));

  @override
  _UploadFailed get _value => super._value as _UploadFailed;

  @override
  $Res call({
    Object? msg = freezed,
  }) {
    return _then(_UploadFailed(
      msg == freezed
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UploadFailed implements _UploadFailed {
  const _$_UploadFailed(this.msg);

  @override
  final String msg;

  @override
  String toString() {
    return 'UploadState.failed(msg: $msg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UploadFailed &&
            const DeepCollectionEquality().equals(other.msg, msg));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(msg));

  @JsonKey(ignore: true)
  @override
  _$UploadFailedCopyWith<_UploadFailed> get copyWith =>
      __$UploadFailedCopyWithImpl<_UploadFailed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(FileModel file) picked,
    required TResult Function(double progress) uploading,
    required TResult Function(FileModel file) success,
    required TResult Function(String msg) failed,
  }) {
    return failed(msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(FileModel file)? picked,
    TResult Function(double progress)? uploading,
    TResult Function(FileModel file)? success,
    TResult Function(String msg)? failed,
  }) {
    return failed?.call(msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(FileModel file)? picked,
    TResult Function(double progress)? uploading,
    TResult Function(FileModel file)? success,
    TResult Function(String msg)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UploadInitial value) initial,
    required TResult Function(_UploadPicked value) picked,
    required TResult Function(_Uploading value) uploading,
    required TResult Function(_UploadSuccess value) success,
    required TResult Function(_UploadFailed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UploadInitial value)? initial,
    TResult Function(_UploadPicked value)? picked,
    TResult Function(_Uploading value)? uploading,
    TResult Function(_UploadSuccess value)? success,
    TResult Function(_UploadFailed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UploadInitial value)? initial,
    TResult Function(_UploadPicked value)? picked,
    TResult Function(_Uploading value)? uploading,
    TResult Function(_UploadSuccess value)? success,
    TResult Function(_UploadFailed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _UploadFailed implements UploadState {
  const factory _UploadFailed(String msg) = _$_UploadFailed;

  String get msg;
  @JsonKey(ignore: true)
  _$UploadFailedCopyWith<_UploadFailed> get copyWith =>
      throw _privateConstructorUsedError;
}
