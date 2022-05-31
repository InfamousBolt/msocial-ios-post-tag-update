// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AppPageTearOff {
  const _$AppPageTearOff();

  _Chatting chatting(String userId) {
    return _Chatting(
      userId,
    );
  }

  _GroupChatting groupChatting(String groupId) {
    return _GroupChatting(
      groupId,
    );
  }

  _Commenting commenting(String postID) {
    return _Commenting(
      postID,
    );
  }

  _Others others() {
    return const _Others();
  }
}

/// @nodoc
const $AppPage = _$AppPageTearOff();

/// @nodoc
mixin _$AppPage {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) chatting,
    required TResult Function(String groupId) groupChatting,
    required TResult Function(String postID) commenting,
    required TResult Function() others,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String userId)? chatting,
    TResult Function(String groupId)? groupChatting,
    TResult Function(String postID)? commenting,
    TResult Function()? others,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? chatting,
    TResult Function(String groupId)? groupChatting,
    TResult Function(String postID)? commenting,
    TResult Function()? others,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Chatting value) chatting,
    required TResult Function(_GroupChatting value) groupChatting,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Others value) others,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Chatting value)? chatting,
    TResult Function(_GroupChatting value)? groupChatting,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Others value)? others,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Chatting value)? chatting,
    TResult Function(_GroupChatting value)? groupChatting,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Others value)? others,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppPageCopyWith<$Res> {
  factory $AppPageCopyWith(AppPage value, $Res Function(AppPage) then) =
      _$AppPageCopyWithImpl<$Res>;
}

/// @nodoc
class _$AppPageCopyWithImpl<$Res> implements $AppPageCopyWith<$Res> {
  _$AppPageCopyWithImpl(this._value, this._then);

  final AppPage _value;
  // ignore: unused_field
  final $Res Function(AppPage) _then;
}

/// @nodoc
abstract class _$ChattingCopyWith<$Res> {
  factory _$ChattingCopyWith(_Chatting value, $Res Function(_Chatting) then) =
      __$ChattingCopyWithImpl<$Res>;
  $Res call({String userId});
}

/// @nodoc
class __$ChattingCopyWithImpl<$Res> extends _$AppPageCopyWithImpl<$Res>
    implements _$ChattingCopyWith<$Res> {
  __$ChattingCopyWithImpl(_Chatting _value, $Res Function(_Chatting) _then)
      : super(_value, (v) => _then(v as _Chatting));

  @override
  _Chatting get _value => super._value as _Chatting;

  @override
  $Res call({
    Object? userId = freezed,
  }) {
    return _then(_Chatting(
      userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Chatting implements _Chatting {
  const _$_Chatting(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'AppPage.chatting(userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Chatting &&
            const DeepCollectionEquality().equals(other.userId, userId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(userId));

  @JsonKey(ignore: true)
  @override
  _$ChattingCopyWith<_Chatting> get copyWith =>
      __$ChattingCopyWithImpl<_Chatting>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) chatting,
    required TResult Function(String groupId) groupChatting,
    required TResult Function(String postID) commenting,
    required TResult Function() others,
  }) {
    return chatting(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String userId)? chatting,
    TResult Function(String groupId)? groupChatting,
    TResult Function(String postID)? commenting,
    TResult Function()? others,
  }) {
    return chatting?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? chatting,
    TResult Function(String groupId)? groupChatting,
    TResult Function(String postID)? commenting,
    TResult Function()? others,
    required TResult orElse(),
  }) {
    if (chatting != null) {
      return chatting(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Chatting value) chatting,
    required TResult Function(_GroupChatting value) groupChatting,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Others value) others,
  }) {
    return chatting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Chatting value)? chatting,
    TResult Function(_GroupChatting value)? groupChatting,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Others value)? others,
  }) {
    return chatting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Chatting value)? chatting,
    TResult Function(_GroupChatting value)? groupChatting,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Others value)? others,
    required TResult orElse(),
  }) {
    if (chatting != null) {
      return chatting(this);
    }
    return orElse();
  }
}

abstract class _Chatting implements AppPage {
  const factory _Chatting(String userId) = _$_Chatting;

  String get userId;
  @JsonKey(ignore: true)
  _$ChattingCopyWith<_Chatting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$GroupChattingCopyWith<$Res> {
  factory _$GroupChattingCopyWith(
          _GroupChatting value, $Res Function(_GroupChatting) then) =
      __$GroupChattingCopyWithImpl<$Res>;
  $Res call({String groupId});
}

/// @nodoc
class __$GroupChattingCopyWithImpl<$Res> extends _$AppPageCopyWithImpl<$Res>
    implements _$GroupChattingCopyWith<$Res> {
  __$GroupChattingCopyWithImpl(
      _GroupChatting _value, $Res Function(_GroupChatting) _then)
      : super(_value, (v) => _then(v as _GroupChatting));

  @override
  _GroupChatting get _value => super._value as _GroupChatting;

  @override
  $Res call({
    Object? groupId = freezed,
  }) {
    return _then(_GroupChatting(
      groupId == freezed
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_GroupChatting implements _GroupChatting {
  const _$_GroupChatting(this.groupId);

  @override
  final String groupId;

  @override
  String toString() {
    return 'AppPage.groupChatting(groupId: $groupId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GroupChatting &&
            const DeepCollectionEquality().equals(other.groupId, groupId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(groupId));

  @JsonKey(ignore: true)
  @override
  _$GroupChattingCopyWith<_GroupChatting> get copyWith =>
      __$GroupChattingCopyWithImpl<_GroupChatting>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) chatting,
    required TResult Function(String groupId) groupChatting,
    required TResult Function(String postID) commenting,
    required TResult Function() others,
  }) {
    return groupChatting(groupId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String userId)? chatting,
    TResult Function(String groupId)? groupChatting,
    TResult Function(String postID)? commenting,
    TResult Function()? others,
  }) {
    return groupChatting?.call(groupId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? chatting,
    TResult Function(String groupId)? groupChatting,
    TResult Function(String postID)? commenting,
    TResult Function()? others,
    required TResult orElse(),
  }) {
    if (groupChatting != null) {
      return groupChatting(groupId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Chatting value) chatting,
    required TResult Function(_GroupChatting value) groupChatting,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Others value) others,
  }) {
    return groupChatting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Chatting value)? chatting,
    TResult Function(_GroupChatting value)? groupChatting,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Others value)? others,
  }) {
    return groupChatting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Chatting value)? chatting,
    TResult Function(_GroupChatting value)? groupChatting,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Others value)? others,
    required TResult orElse(),
  }) {
    if (groupChatting != null) {
      return groupChatting(this);
    }
    return orElse();
  }
}

abstract class _GroupChatting implements AppPage {
  const factory _GroupChatting(String groupId) = _$_GroupChatting;

  String get groupId;
  @JsonKey(ignore: true)
  _$GroupChattingCopyWith<_GroupChatting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$CommentingCopyWith<$Res> {
  factory _$CommentingCopyWith(
          _Commenting value, $Res Function(_Commenting) then) =
      __$CommentingCopyWithImpl<$Res>;
  $Res call({String postID});
}

/// @nodoc
class __$CommentingCopyWithImpl<$Res> extends _$AppPageCopyWithImpl<$Res>
    implements _$CommentingCopyWith<$Res> {
  __$CommentingCopyWithImpl(
      _Commenting _value, $Res Function(_Commenting) _then)
      : super(_value, (v) => _then(v as _Commenting));

  @override
  _Commenting get _value => super._value as _Commenting;

  @override
  $Res call({
    Object? postID = freezed,
  }) {
    return _then(_Commenting(
      postID == freezed
          ? _value.postID
          : postID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Commenting implements _Commenting {
  const _$_Commenting(this.postID);

  @override
  final String postID;

  @override
  String toString() {
    return 'AppPage.commenting(postID: $postID)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Commenting &&
            const DeepCollectionEquality().equals(other.postID, postID));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(postID));

  @JsonKey(ignore: true)
  @override
  _$CommentingCopyWith<_Commenting> get copyWith =>
      __$CommentingCopyWithImpl<_Commenting>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) chatting,
    required TResult Function(String groupId) groupChatting,
    required TResult Function(String postID) commenting,
    required TResult Function() others,
  }) {
    return commenting(postID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String userId)? chatting,
    TResult Function(String groupId)? groupChatting,
    TResult Function(String postID)? commenting,
    TResult Function()? others,
  }) {
    return commenting?.call(postID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? chatting,
    TResult Function(String groupId)? groupChatting,
    TResult Function(String postID)? commenting,
    TResult Function()? others,
    required TResult orElse(),
  }) {
    if (commenting != null) {
      return commenting(postID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Chatting value) chatting,
    required TResult Function(_GroupChatting value) groupChatting,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Others value) others,
  }) {
    return commenting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Chatting value)? chatting,
    TResult Function(_GroupChatting value)? groupChatting,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Others value)? others,
  }) {
    return commenting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Chatting value)? chatting,
    TResult Function(_GroupChatting value)? groupChatting,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Others value)? others,
    required TResult orElse(),
  }) {
    if (commenting != null) {
      return commenting(this);
    }
    return orElse();
  }
}

abstract class _Commenting implements AppPage {
  const factory _Commenting(String postID) = _$_Commenting;

  String get postID;
  @JsonKey(ignore: true)
  _$CommentingCopyWith<_Commenting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$OthersCopyWith<$Res> {
  factory _$OthersCopyWith(_Others value, $Res Function(_Others) then) =
      __$OthersCopyWithImpl<$Res>;
}

/// @nodoc
class __$OthersCopyWithImpl<$Res> extends _$AppPageCopyWithImpl<$Res>
    implements _$OthersCopyWith<$Res> {
  __$OthersCopyWithImpl(_Others _value, $Res Function(_Others) _then)
      : super(_value, (v) => _then(v as _Others));

  @override
  _Others get _value => super._value as _Others;
}

/// @nodoc

class _$_Others implements _Others {
  const _$_Others();

  @override
  String toString() {
    return 'AppPage.others()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Others);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) chatting,
    required TResult Function(String groupId) groupChatting,
    required TResult Function(String postID) commenting,
    required TResult Function() others,
  }) {
    return others();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String userId)? chatting,
    TResult Function(String groupId)? groupChatting,
    TResult Function(String postID)? commenting,
    TResult Function()? others,
  }) {
    return others?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? chatting,
    TResult Function(String groupId)? groupChatting,
    TResult Function(String postID)? commenting,
    TResult Function()? others,
    required TResult orElse(),
  }) {
    if (others != null) {
      return others();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Chatting value) chatting,
    required TResult Function(_GroupChatting value) groupChatting,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Others value) others,
  }) {
    return others(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Chatting value)? chatting,
    TResult Function(_GroupChatting value)? groupChatting,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Others value)? others,
  }) {
    return others?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Chatting value)? chatting,
    TResult Function(_GroupChatting value)? groupChatting,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Others value)? others,
    required TResult orElse(),
  }) {
    if (others != null) {
      return others(this);
    }
    return orElse();
  }
}

abstract class _Others implements AppPage {
  const factory _Others() = _$_Others;
}
