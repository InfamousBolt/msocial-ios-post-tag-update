import 'package:equatable/equatable.dart';

import '../../../imports.dart';

class Group extends Equatable {
  final String id;
  final String name;
  final int membersCount;
  final String photoURL;
  final bool byAdmin;
  final List<String> admins;
  final List<String> members;
  final List<String> mutedFor;
  final List<String> blockedUsers;
  final List<String> typing;

  const Group({
    required this.id,
    required this.name,
    required this.membersCount,
    required this.photoURL,
    required this.byAdmin,
    required this.admins,
    required this.members,
    required this.mutedFor,
    required this.blockedUsers,
    required this.typing,
  });

  String get _uid => authProvider.uid;

  bool isMember([String? userId]) => members.contains(userId ?? _uid);
  void toggleJoin() => isMember() ? members.remove(_uid) : members.add(_uid);

  bool isMuted([String? userId]) => mutedFor.contains(userId ?? _uid);
  void toggleMute() => isMuted() ? mutedFor.remove(_uid) : mutedFor.add(_uid);

  bool isBlocked([String? userId]) => blockedUsers.contains(userId ?? _uid);
  void toggleBlock() =>
      isBlocked() ? blockedUsers.remove(_uid) : blockedUsers.add(_uid);

  bool isAdmin([String? userId]) => admins.contains(userId ?? _uid);

  bool get isTyping => (typing..remove(_uid)).isNotEmpty;

  factory Group.create({
    required String name,
    required String photoURL,
  }) {
    final uid = authProvider.uid;
    return Group(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      byAdmin: true,
      admins: [uid],
      members: [uid],
      membersCount: 0,
      mutedFor: const [],
      photoURL: photoURL,
      blockedUsers: const [],
      typing: const [],
    );
  }
  List<String> get searchIndexes {
    final indices = <String>[];
    for (var i = 1; i < name.length; i++) {
      indices.add(name.substring(0, i).toLowerCase());
    }
    return indices;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'membersCount': membersCount,
      'searchIndexes': searchIndexes,
      'photoURL': photoURL,
      'byAdmin' : byAdmin,
      'admins': admins,
      'members': members,
      'mutedFor': mutedFor,
      'blockedUsers': blockedUsers,
      'typing': typing,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: parseString(map['id']),
      name: parseString(map['name']),
      membersCount: parseInt(map['membersCount']),
      photoURL: parseString(map['photoURL']),
      byAdmin: parseBool(map['byAdmin']),
      admins: List<String>.from(map['admins'] as List? ?? const []),
      members: List<String>.from(map['members'] as List? ?? const []),
      mutedFor: List<String>.from(map['mutedFor'] as List? ?? const []),
      blockedUsers: List<String>.from(map['blockedUsers'] as List? ?? const []),
      typing: List<String>.from(map['typing'] as List? ?? const []),
    );
  }

  Group copyWith({
    String? id,
    String? name,
    int? membersCount,
    String? photoURL,
    bool? byAdmin,
    List<String>? admins,
    List<String>? members,
    List<String>? mutedFor,
    List<String>? blockedUsers,
    List<String>? typing,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      membersCount: membersCount ?? this.membersCount,
      photoURL: photoURL ?? this.photoURL,
      byAdmin: byAdmin ?? true,
      admins: admins ?? this.admins,
      members: members ?? this.members,
      mutedFor: mutedFor ?? this.mutedFor,
      blockedUsers: blockedUsers ?? this.blockedUsers,
      typing: typing ?? this.typing,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      membersCount,
      photoURL,
      byAdmin,
      admins,
      members,
      mutedFor,
      blockedUsers,
      typing,
    ];
  }
}
