import 'package:equatable/equatable.dart';

import '../../../imports.dart';

class Comment extends Equatable {
  final String id;
  final String? postID;
  final String? postAuthorID;
  final String authorID;
  final String authorName;
  final String authorPhotoURL;
  final String? parentID;
  final String? content;
  final DateTime? createdAt;
  final List<Comment> replyComments;
  final List<String> usersLikeIds;
  const Comment({
    required this.id,
    required this.postID,
    required this.postAuthorID,
    required this.authorID,
    required this.authorName,
    required this.authorPhotoURL,
    required this.parentID,
    required this.content,
    required this.createdAt,
    required this.replyComments,
    required this.usersLikeIds,
  });
  String get uid => authProvider.user!.id;

  bool get isMine => authorID == uid;

  bool get isLiked => usersLikeIds.contains(uid);
  void toggleLike() =>
      isLiked ? usersLikeIds.remove(uid) : usersLikeIds.add(uid);

  factory Comment.create({
    String? content,
    String? postID,
    String? postAuthorID,
    String? parentID,
  }) {
    final currentUser = authProvider.user!;
    return Comment(
      id: '${DateTime.now().millisecondsSinceEpoch}-${currentUser.username}',
      content: content,
      postID: postID,
      postAuthorID: postAuthorID,
      authorID: currentUser.id,
      authorName: currentUser.username,
      authorPhotoURL: currentUser.photoURL,
      createdAt: DateTime.now().toUtc(),
      usersLikeIds: const [],
      replyComments: const [],
      parentID: parentID,
    );
  }

  factory Comment.fromMap(Map<dynamic, dynamic> map) {
    return Comment(
      id: parseString(map['id']),
      postID: parseString(map['postID']),
      postAuthorID: parseString(map['postAuthorID']),
      authorID: parseString(map['authorID']),
      authorName: parseString(map['authorName']),
      authorPhotoURL: parseString(map['authorPhotoURL']),
      parentID: parseString(map['parentID']),
      content: parseString(map['content']),
      createdAt: parseDate(map['createdAt']),
      replyComments: [
        for (final e in map['replyComments'] as List? ?? [])
          Comment.fromMap(e as Map)
      ],
      usersLikeIds: List<String>.from(map['usersLikeIds'] as List? ?? const []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postID': postID,
      'postAuthorID': postAuthorID,
      'authorID': authorID,
      'authorName': authorName,
      'authorPhotoURL': authorPhotoURL,
      'parentID': parentID,
      'content': content,
      'createdAt': createdAt,
      'replyComments': [for (final x in replyComments) x.toMap()],
      'usersLikeIds': usersLikeIds,
    };
  }

  Comment copyWith({
    String? id,
    String? postID,
    String? postAuthorID,
    String? authorID,
    String? authorName,
    String? authorPhotoURL,
    String? parentID,
    String? content,
    DateTime? createdAt,
    List<Comment>? replyComments,
    List<String>? usersLikeIds,
  }) {
    return Comment(
      id: id ?? this.id,
      postID: postID ?? this.postID,
      postAuthorID: postAuthorID ?? this.postAuthorID,
      authorID: authorID ?? this.authorID,
      authorName: authorName ?? this.authorName,
      authorPhotoURL: authorPhotoURL ?? this.authorPhotoURL,
      parentID: parentID ?? this.parentID,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      replyComments: replyComments ?? this.replyComments,
      usersLikeIds: usersLikeIds ?? this.usersLikeIds,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      postID,
      postAuthorID,
      authorID,
      authorName,
      authorPhotoURL,
      parentID,
      content,
      createdAt,
      replyComments,
      usersLikeIds,
    ];
  }
}
