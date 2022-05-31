import 'package:equatable/equatable.dart';

import '../../../imports.dart';
import 'post.dart';

class PostReaction extends Equatable {
  final String id;
  final String postID;
  final String postOwnerId;
  final String postOwnerName;
  final String reactionOwnerID;
  final String reactionOwnerName;
  final String reactionOwnerPhotoURL;
  final DateTime? createdAt;
  const PostReaction({
    required this.id,
    required this.postID,
    required this.postOwnerId,
    required this.postOwnerName,
    required this.reactionOwnerID,
    required this.reactionOwnerName,
    required this.reactionOwnerPhotoURL,
    required this.createdAt,
  });

  String get uid => authProvider.user!.id;

  bool get isMine => reactionOwnerID == uid;

  factory PostReaction.create(Post post) {
    final currentUser = authProvider.user!;
    return PostReaction(
      id: '${DateTime.now().millisecondsSinceEpoch}-${currentUser.username}',
      postID: post.id,
      postOwnerId: post.authorID,
      postOwnerName: post.authorName,
      reactionOwnerID: currentUser.id,
      reactionOwnerName: currentUser.username,
      reactionOwnerPhotoURL: currentUser.photoURL,
      createdAt: DateTime.now().toUtc(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postID': postID,
      'postOwnerId': postOwnerId,
      'postOwnerName': postOwnerName,
      'reactionOwnerID': reactionOwnerID,
      'reactionOwnerName': reactionOwnerName,
      'reactionOwnerPhotoURL': reactionOwnerPhotoURL,
      'createdAt': createdAt,
    };
  }

  factory PostReaction.fromMap(Map<String, dynamic> map) {
    return PostReaction(
      id: parseString(map['id']),
      postID: parseString(map['postID']),
      postOwnerId: parseString(map['postOwnerId']),
      postOwnerName: parseString(map['postOwnerName']),
      reactionOwnerID: parseString(map['reactionOwnerID']),
      reactionOwnerName: parseString(map['reactionOwnerName']),
      reactionOwnerPhotoURL: parseString(map['reactionOwnerPhotoURL']),
      createdAt: parseDate(map['createdAt']),
    );
  }

  PostReaction copyWith({
    String? id,
    String? postID,
    String? postOwnerId,
    String? postOwnerName,
    String? reactionOwnerID,
    String? reactionOwnerName,
    String? reactionOwnerPhotoURL,
    DateTime? createdAt,
  }) {
    return PostReaction(
      id: id ?? this.id,
      postID: postID ?? this.postID,
      postOwnerId: postOwnerId ?? this.postOwnerId,
      postOwnerName: postOwnerName ?? this.postOwnerName,
      reactionOwnerID: reactionOwnerID ?? this.reactionOwnerID,
      reactionOwnerName: reactionOwnerName ?? this.reactionOwnerName,
      reactionOwnerPhotoURL:
          reactionOwnerPhotoURL ?? this.reactionOwnerPhotoURL,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      postID,
      postOwnerId,
      postOwnerName,
      reactionOwnerID,
      reactionOwnerName,
      reactionOwnerPhotoURL,
      createdAt,
    ];
  }
}
