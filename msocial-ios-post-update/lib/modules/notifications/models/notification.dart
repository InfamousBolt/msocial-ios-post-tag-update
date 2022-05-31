import 'package:equatable/equatable.dart';

import '../../../imports.dart';

class NotificationModel extends Equatable {
  final String id;
  final String? toId;
  final String fromId;
  final String fromName;
  final DateTime? createdAt;
  final int type;

  //Post Comment or Reaction
  final String? postID;
  //Comment Reply or Reaction
  final String? commentID;

  const NotificationModel({
    required this.id,
    required this.toId,
    required this.fromId,
    required this.fromName,
    required this.createdAt,
    required this.type,
    this.postID,
    this.commentID,
  });

  bool get isFollow => type == NotificationType.Follow.index;
  bool get isPostReaction => type == NotificationType.PostReaction.index;
  bool get isComment => type == NotificationType.Comment.index;
  bool get isCommentReaction => type == NotificationType.CommentReaction.index;
  bool get isReply => type == NotificationType.Reply.index;

  String get text {
    if (isFollow) {
      return '$fromName ${t.StartFollowingMsg}';
    } else if (isPostReaction) {
      return '$fromName ${t.PostReactionMsg}';
    } else if (isComment) {
      return '$fromName ${t.PostCommentMsg}';
    } else if (isCommentReaction) {
      return '$fromName ${t.CommentReactedMsg}';
    } else if (isReply) {
      return '$fromName ${t.Replies}';
    } else {
      return '';
    }
  }

  factory NotificationModel.create({
    String? toId,
    required NotificationType type,
    String? postID,
    String? commentID,
  }) {
    final user = authProvider.user!;
    return NotificationModel(
      id: '${type.index}-${postID ?? ''}-${commentID ?? ''}${user.username}-$toId',
      toId: toId,
      fromId: user.id,
      fromName: user.username,
      createdAt: DateTime.now().toUtc(),
      type: type.index,
      postID: postID,
      commentID: commentID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'toId': toId,
      'fromId': fromId,
      'fromName': fromName,
      'createdAt': createdAt,
      'type': type,
      'postID': postID,
      'commentID': commentID,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: parseString(map['id']),
      toId: parseString(map['toId']),
      fromId: parseString(map['fromId']),
      fromName: parseString(map['fromName']),
      createdAt: parseDate(map['createdAt']),
      type: parseInt(map['type']),
      postID: parseString(map['postID']),
      commentID: parseString(map['commentID']),
    );
  }

  NotificationModel copyWith({
    String? id,
    String? toId,
    String? fromId,
    String? fromName,
    DateTime? createdAt,
    int? type,
    String? postID,
    String? commentID,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      toId: toId ?? this.toId,
      fromId: fromId ?? this.fromId,
      fromName: fromName ?? this.fromName,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      postID: postID ?? this.postID,
      commentID: commentID ?? this.commentID,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      toId,
      fromId,
      fromName,
      createdAt,
      type,
      postID,
      commentID,
    ];
  }
}

enum NotificationType { Follow, PostReaction, Comment, CommentReaction, Reply }
