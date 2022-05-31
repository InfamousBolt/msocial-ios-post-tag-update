import 'package:equatable/equatable.dart';

import '../../../imports.dart';

class Chat extends Equatable {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> users;
  final List<String> visibleTo;
  final List<String> typing;
  const Chat({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.users,
    required this.visibleTo,
    required this.typing,
  });

  static String? get _uid => authProvider.uid;
  String? get getSenderId => guard(() => (users..remove(_uid)).first, '');

  static String getChatId(String userID) =>
      _uid!.compareTo(userID) <= -1 ? '$_uid-$userID' : '$userID-$_uid';

  bool get isTyping => (typing..remove(_uid)).isNotEmpty;

  factory Chat.fromMessage(Message message) {
    return Chat(
      id: message.chatID,
      users: message.visibleTo,
      visibleTo: message.visibleTo,
      updatedAt: message.createdAt,
      createdAt: message.createdAt,
      typing: const [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'users': users,
      'visibleTo': visibleTo,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'typing': typing,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: parseString(map['id']),
      updatedAt: parseDate(map['updatedAt'] ?? map['updateTime']),
      createdAt: parseDate(map['createdAt']),
      users: List<String>.from(map['users'] as List? ?? []),
      visibleTo: List<String>.from(map['visibleTo'] as List? ?? []),
      typing: List<String>.from(map['typing'] as List? ?? []),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      createdAt,
      updatedAt,
      users,
      visibleTo,
      typing,
    ];
  }

  Chat copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? users,
    List<String>? visibleTo,
    List<String>? typing,
  }) {
    return Chat(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      users: users ?? this.users,
      visibleTo: visibleTo ?? this.visibleTo,
      typing: typing ?? this.typing,
    );
  }
}
