import 'package:equatable/equatable.dart';

import '../../../imports.dart';

class Post extends Equatable {
  final String id;
  final String authorID;
  final String authorName;
  final String authorPhotoURL;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String content;
  final List<String> usersLikes;
  final List<String> commentsIDs;
  final List<String> reportedBy;
  final ImageModel? image;
  final bool isShared;

  const Post({
    required this.id,
    required this.authorID,
    required this.authorName,
    required this.authorPhotoURL,
    required this.createdAt,
    required this.updatedAt,
    required this.content,
    this.reportedBy = const [],
    this.usersLikes = const [],
    this.commentsIDs = const [],
    this.isShared = false,
    this.image,
  });
  factory Post.create({
    String content = '',
    ImageModel? image,
  }) {
    final currentUser = authProvider.user!;
    return Post(
      id: '${DateTime.now().millisecondsSinceEpoch}-${currentUser.username}',
      authorID: currentUser.id,
      authorName: currentUser.username,
      authorPhotoURL: currentUser.photoURL,
      content: content,
      createdAt: DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
      image: image,
    );
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: parseString(map['id']),
      authorID: parseString(map['authorID']),
      authorName: parseString(map['authorName']),
      authorPhotoURL: parseString(map['authorPhotoURL']),
      createdAt: parseDate(map['createdAt']),
      updatedAt: parseDate(map['updatedAt']),
      content: parseString(map['content']),
      usersLikes: List<String>.from(map['usersLikes'] as List? ?? const []),
      commentsIDs: List<String>.from(map['commentsIDs'] as List? ?? const []),
      reportedBy: List<String>.from(map['reportedBy'] as List? ?? const []),
      isShared: parseBool(map['isShared']),
      image: ImageModel.fromMap(
        Map<String, dynamic>.from(map['image'] as Map? ?? {}),
      ),
    );
  }
  User get getUser => User.createNew(
        uid: authorID,
        username: authorName,
        photoURL: authorPhotoURL,
        phone: '',
      );
  bool get hasImage => image?.path.isNotEmpty == true;
  bool get isMine => authorID == _uid;
  bool get isReported => reportedBy.isNotEmpty;

  bool get liked => usersLikes.contains(_uid);

  @override
  List<Object?> get props {
    return [
      id,
      authorID,
      authorName,
      authorPhotoURL,
      createdAt,
      updatedAt,
      content,
      usersLikes,
      commentsIDs,
      reportedBy,
      image,
      isShared,
    ];
  }

  bool get show => (isShared || isMine) && !reportedBy.contains(_uid);

  @override
  bool get stringify => true;

  String get _uid => authProvider.user!.id;

  Post copyWith({
    String? id,
    String? authorID,
    String? authorName,
    String? authorPhotoURL,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? content,
    List<String>? usersLikes,
    List<String>? commentsIDs,
    List<String>? reportedBy,
    ImageModel? image,
    bool? isShared,
  }) {
    return Post(
      id: id ?? this.id,
      authorID: authorID ?? this.authorID,
      authorName: authorName ?? this.authorName,
      authorPhotoURL: authorPhotoURL ?? this.authorPhotoURL,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      content: content ?? this.content,
      usersLikes: usersLikes ?? this.usersLikes,
      commentsIDs: commentsIDs ?? this.commentsIDs,
      reportedBy: reportedBy ?? this.reportedBy,
      image: image ?? this.image,
      isShared: isShared ?? this.isShared,
    );
  }

  void toggleLike() => liked ? usersLikes.remove(_uid) : usersLikes.add(_uid);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'authorID': authorID,
      'authorName': authorName,
      'authorPhotoURL': authorPhotoURL,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'content': content,
      'usersLikes': usersLikes,
      'likesCount': usersLikes.length,
      'commentsIDs': commentsIDs,
      'commentsCount': commentsIDs.length,
      'reportedBy': reportedBy,
      'isShared': isShared,
      'image': image?.toMap(),
    }..removeWhere((_, v) => '${v ?? ''}'.isEmpty);
  }
}
