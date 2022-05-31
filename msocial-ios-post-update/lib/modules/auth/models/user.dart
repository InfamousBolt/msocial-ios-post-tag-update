import 'package:equatable/equatable.dart';

import '../../../core/utils.dart';
import '../provider.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String status;
  final String email;
  final String phone;
  final String photoURL;
  final String coverPhotoURL;
  final String country;
  final String gender;
  final bool isBanned;
  final bool isAdmin;
  final bool isVerified;
  final bool isBadged;
  final bool isBrand;
  bool wantsBrand;
  final bool isActive;
  final DateTime activeAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> reportedBy;
  final List<String> posts;
  final List<String> followers;
  final List<String> following;
  final List<String> blockedBy;
  final bool chatNotify;
  final bool groupsNotify;
  final bool onlineStatus;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.status,
    required this.email,
    required this.phone,
    required this.photoURL,
    required this.coverPhotoURL,
    required this.country,
    required this.gender,
    required this.isBanned,
    required this.isAdmin,
    required this.isVerified,
    required this.isBadged,
    required this.isBrand,
    required this.wantsBrand,
    required this.isActive,
    required this.activeAt,
    required this.createdAt,
    required this.updatedAt,
    required this.reportedBy,
    required this.posts,
    required this.followers,
    required this.following,
    required this.blockedBy,
    required this.chatNotify,
    required this.groupsNotify,
    required this.onlineStatus,
  });

  factory User.createNew({
    required String uid,
    required String phone,
    required String username,
    String? firstName,
    String? lastName,
    String? country,
    String? photoURL,
    String? coverPhoto,
    String? email,
    String? status,
    String? gender,
  }) {
    return User(
      id: uid,
      username: username,
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      photoURL: photoURL ?? '',
      status: status ?? '',
      coverPhotoURL: coverPhoto ?? '',
      phone: phone,
      country: country ?? '',
      gender: gender ?? '',
      isBanned: false,
      isAdmin: false,
      isVerified : false,
      isBadged : false,
      isBrand : false,
      wantsBrand : false,
      isActive: true,
      activeAt: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      posts: const <String>[],
      followers: const <String>[],
      following: const <String>[],
      blockedBy: const <String>[],
      reportedBy: const <String>[],
      onlineStatus: true,
      chatNotify: true,
      groupsNotify: true,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: parseString(map['id']),
      username: parseString(map['username'] ?? map['name']),
      firstName: parseString(map['firstName']),
      lastName: parseString(map['lastName']),
      status: parseString(map['status']),
      email: parseString(map['email']),
      phone: parseString(map['phone'] ?? map['phoneNumber']),
      photoURL: parseString(map['photoURL'] ?? map['photoURL']),
      coverPhotoURL: parseString(map['coverPhotoURL']),
      onlineStatus: parseBool(map['onlineStatus']),
      country: parseString(map['country']),
      gender: parseString(map['gender']),
      isBanned: parseBool(map['isBanned']),
      isAdmin: parseBool(map['isAdmin']),
      isVerified: parseBool(map['isVerified']),
      isBadged: parseBool(map['isBadged']),
      isBrand: parseBool(map['isBrand']),
      wantsBrand: parseBool(map['wantsBrand']),
      isActive: parseBool(map['isActive']),
      activeAt: parseDate(map['lastTimeSeen'] ?? map['activeAt']),
      createdAt: parseDate(map['createdAt']),
      updatedAt: parseDate(map['updatedAt']),
      chatNotify: parseBool(map['chatNotify']),
      groupsNotify: parseBool(map['groupsNotify']),
      reportedBy: List<String>.from(map['reportedBy'] as List? ?? const []),
      posts: List<String>.from(map['posts'] as List? ?? []),
      followers: List<String>.from(map['followers'] as List? ?? []),
      following: List<String>.from(map['following'] as List? ?? []),
      blockedBy: List<String>.from(map['blockedBy'] as List? ?? []),
    );
  }
  String get fullName => '$firstName $lastName';

  bool get isFollowed => followers.contains(_uid);
  bool get isFollowing => authProvider.user!.following.contains(id);
  bool get isMe => id == _uid;

  bool get isOnline =>
      isActive && DateTime.now().difference(activeAt).inMinutes < 20;
  @override
  List<Object?> get props {
    return [
      id,
      username,
      firstName,
      lastName,
      status,
      email,
      phone,
      photoURL,
      coverPhotoURL,
      country,
      gender,
      isBanned,
      isAdmin,
      isVerified,
      isBadged,
      isBrand,
      wantsBrand,
      isActive,
      activeAt,
      createdAt,
      updatedAt,
      reportedBy,
      posts,
      followers,
      following,
      blockedBy,
      chatNotify,
      groupsNotify,
      onlineStatus,
    ];
  }

  List<String> get searchIndexes {
    final indices = <String>[];
    for (final s in [username, firstName, lastName]) {
      for (var i = 1; i < s.length; i++) {
        indices.add(s.substring(0, i).toLowerCase());
      }
    }
    indices.add(username.toLowerCase());
    indices.add(firstName.toLowerCase());
    indices.add(lastName.toLowerCase());

    return indices;
  }

  @override
  bool get stringify => true;

  String get _uid => authProvider.uid;

  User copyWith({
    String? id,
    String? username,
    String? firstName,
    String? lastName,
    String? status,
    String? email,
    String? phone,
    String? photoURL,
    String? coverPhotoURL,
    String? country,
    String? gender,
    bool? isBanned,
    bool? isAdmin,
    bool? isVerified,
    bool? isBadged,
    bool? isBrand,
    bool? wantsBrand,
    bool? isActive,
    DateTime? activeAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? reportedBy,
    List<String>? posts,
    List<String>? followers,
    List<String>? following,
    List<String>? blockedBy,
    bool? chatNotify,
    bool? groupsNotify,
    bool? onlineStatus,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      status: status ?? this.status,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoURL: photoURL ?? this.photoURL,
      coverPhotoURL: coverPhotoURL ?? this.coverPhotoURL,
      country: country ?? this.country,
      gender: gender ?? this.gender,
      isBanned: isBanned ?? this.isBanned,
      isAdmin: isAdmin ?? this.isAdmin,
      isVerified: isVerified ?? this.isVerified,
      isBadged: isBadged ?? this.isBadged,
      isBrand: isBrand ?? this.isBrand,
      wantsBrand: wantsBrand ?? this.wantsBrand,
      isActive: isActive ?? this.isActive,
      activeAt: activeAt ?? this.activeAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reportedBy: reportedBy ?? this.reportedBy,
      posts: posts ?? this.posts,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      blockedBy: blockedBy ?? this.blockedBy,
      chatNotify: chatNotify ?? this.chatNotify,
      groupsNotify: groupsNotify ?? this.groupsNotify,
      onlineStatus: onlineStatus ?? this.onlineStatus,
    );
  }

  bool isBlocked([String? uid]) => blockedBy.contains(uid ?? _uid);

  void toggleBlock() =>
      isBlocked() ? blockedBy.remove(_uid) : blockedBy.add(_uid);

  void toggleFollowing() {
    final currentUser = authProvider.user!;
    if (followers.contains(_uid)) {
      followers.remove(_uid);
      currentUser.following.remove(id);
    } else {
      followers.add(_uid);
      currentUser.following.add(id);
    }
    authProvider.rxUser(currentUser);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'status': status,
      'email': email,
      'phone': phone,
      'photoURL': photoURL,
      'coverPhotoURL': coverPhotoURL,
      'onlineStatus': onlineStatus,
      'country': country,
      'gender': gender,
      'isBanned': isBanned,
      'isAdmin': isAdmin,
      'isVerified' : isVerified,
      'isBadged' : isBadged,
      'isBrand' : isBrand,
      'wantsBrand' : wantsBrand,
      'isActive': isActive,
      'activeAt': activeAt,
      'createdAt': createdAt,
      'reporters': reportedBy,
      'chatNotify': chatNotify,
      'groupsNotify': groupsNotify,
      'posts': posts,
      'followers': followers,
      'following': following,
      'blockedBy': blockedBy,
      'searchIndexes': searchIndexes,
    };
  }
}
