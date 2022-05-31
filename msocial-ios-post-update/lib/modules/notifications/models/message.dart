import 'package:equatable/equatable.dart';

import '../../../core/utils.dart';

class MessageNotification extends Equatable {
  final String fromID;
  final String fromName;
  final String fromPhotoURL;
  final String groupID;
  final String groupName;
  final String type;
  final String title;
  final String body;
  const MessageNotification({
    required this.fromID,
    required this.fromName,
    required this.fromPhotoURL,
    required this.groupID,
    required this.groupName,
    required this.type,
    required this.title,
    required this.body,
  });

  bool get isGroup => groupID.isNotEmpty;

  factory MessageNotification.fromMap(Map<String, dynamic> map) {
    return MessageNotification(
      fromID: parseString(map['fromID']),
      fromName: parseString(map['fromName']),
      fromPhotoURL: parseString(map['fromPhotoURL']),
      groupID: parseString(map['groupID']),
      groupName: parseString(map['groupName']),
      type: parseString(map['type']),
      title: parseString(map['title']),
      body: parseString(map['body']),
    );
  }

  MessageNotification copyWith({
    String? fromID,
    String? fromName,
    String? fromPhotoURL,
    String? groupID,
    String? groupName,
    String? type,
    String? title,
    String? body,
  }) {
    return MessageNotification(
      fromID: fromID ?? this.fromID,
      fromName: fromName ?? this.fromName,
      fromPhotoURL: fromPhotoURL ?? this.fromPhotoURL,
      groupID: groupID ?? this.groupID,
      groupName: groupName ?? this.groupName,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      fromID,
      fromName,
      fromPhotoURL,
      groupID,
      groupName,
      type,
      title,
      body,
    ];
  }
}
