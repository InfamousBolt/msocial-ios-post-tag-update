import 'package:equatable/equatable.dart';
import 'package:profanity_filter/profanity_filter.dart';

import '../../../imports.dart';
import 'chat.dart';

class Message extends Equatable {
  final String id;
  final String chatID;
  final String groupID;
  final String fromID;
  final String fromName;
  final String fromPhotoURL;
  final String toID;
  final String content;
  final DateTime createdAt;
  final List<String> visibleTo;
  final List<String> seenBy;
  final int type;
  final ImageModel? image;

  const Message({
    required this.id,
    required this.chatID,
    required this.groupID,
    required this.fromID,
    required this.fromName,
    required this.fromPhotoURL,
    required this.toID,
    required this.content,
    required this.createdAt,
    required this.visibleTo,
    required this.seenBy,
    required this.type,
    this.image,
  });

  String get _uid => authProvider.user!.id;

  bool get isFromMe => fromID == _uid;
  bool get isSending => seenBy.isEmpty && isFromMe;
  bool get isSent => seenBy.contains(fromID);
  bool get isSeenByMe => isFromMe || seenBy.contains(_uid);
  bool get isGroup => groupID.isNotEmpty;
  bool get isRead => seenBy.length > 1 && seenBy.contains(toID);

  bool get isText => type == MessageType.Text.index;
  bool get isImage =>
      type == MessageType.Image.index && image?.path.isNotEmpty == true;
  bool get isEmoji => type == MessageType.Emoji.index;
  bool get isGIF => type == MessageType.GIF.index;
  bool get isSticker => type == MessageType.Sticker.index;

  String get desc {
    if (isImage) {
      return '📷 ${t.Image}';
    } else if (isEmoji || isGIF) {
      return '✨ ${t.GIF}';
    } else if (isSticker) {
      return '✨ ${t.Sticker}';
    } else {
      return content;
    }
  }

  static Message? create({
    String sendToId = '',
    String groupId = '',
    String content = '',
    MessageType type = MessageType.Text,
    ImageModel? image,
  }) {
    if (type == MessageType.Text) {
      if (content.isEmpty) {
        return null;
      } else if (ProfanityFilter().hasProfanity(content)) {
        BotToast.showText(
          text: t.ProfanityDetected,
          duration: Duration(seconds: 5),
        );
        return null;
      }
    }
    final currentUser = authProvider.user!;
    final isGroup = groupId.isNotEmpty;
    return Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chatID: isGroup ? '' : Chat.getChatId(sendToId),
      groupID: groupId,
      fromPhotoURL: currentUser.photoURL,
      fromName: currentUser.username,
      toID: sendToId,
      visibleTo: isGroup ? [] : [currentUser.id, sendToId],
      fromID: currentUser.id,
      createdAt: DateTime.now(),
      content: content,
      type: type.index,
      seenBy: const [],
      image: image,
    );
  }

  Message makeAsSent() => isSent ? this : copyWith(seenBy: [...seenBy, _uid]);

  Message? edit(String content) {
    if (content.trim().isNotEmpty != true) {
      return null;
    } else if (ProfanityFilter().hasProfanity(content)) {
      BotToast.showText(
        text: t.ProfanityDetected,
        duration: Duration(seconds: 5),
      );
      return null;
    }
    return copyWith(content: content);
  }

  static List<Message> mergeMsgs(List<Message> c, List<Message>? o) {
    if (c == o) return c;
    final merged = [...c];
    if (o?.isNotEmpty != true) return merged;
    final ids = [for (final m in c) m.id];

    for (final om in o!) {
      final i = ids.indexOf(om.id);
      if (i == -1) {
        merged.add(om);
      } else {
        merged[i] = om;
      }
    }
    merged.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return merged;
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: parseString(map['id']),
      chatID: parseString(map['chatID']),
      groupID: parseString(map['groupID']),
      fromID: parseString(map['fromID']),
      fromName: parseString(map['fromName']),
      fromPhotoURL: parseString(map['fromPhotoURL']),
      toID: parseString(map['toID']),
      content: parseString(map['content']),
      createdAt: parseDate(map['createdAt']),
      type: parseInt(map['type']),
      visibleTo: List<String>.from(map['visibleTo'] as List? ?? []),
      seenBy: List<String>.from(map['seenBy'] as List? ?? []),
      image: ImageModel.fromMap(
        Map<String, dynamic>.from(map['image'] as Map? ?? {}),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatID': chatID,
      'groupID': groupID,
      'fromID': fromID,
      'fromName': fromName,
      'fromPhotoURL': fromPhotoURL,
      'toID': toID,
      'content': content,
      'createdAt': createdAt,
      'visibleTo': visibleTo,
      'seenBy': seenBy,
      'type': type,
      'image': image?.toMap(),
    }..removeWhere((_, v) => '${v ?? ''}'.isEmpty);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      chatID,
      groupID,
      fromID,
      fromName,
      fromPhotoURL,
      toID,
      content,
      createdAt,
      visibleTo,
      seenBy,
      type,
      image,
    ];
  }

  Message copyWith({
    String? id,
    String? chatID,
    String? groupID,
    String? fromID,
    String? fromName,
    String? fromPhotoURL,
    String? toID,
    String? content,
    DateTime? createdAt,
    List<String>? visibleTo,
    List<String>? seenBy,
    int? type,
    ImageModel? image,
  }) {
    return Message(
      id: id ?? this.id,
      chatID: chatID ?? this.chatID,
      groupID: groupID ?? this.groupID,
      fromID: fromID ?? this.fromID,
      fromName: fromName ?? this.fromName,
      fromPhotoURL: fromPhotoURL ?? this.fromPhotoURL,
      toID: toID ?? this.toID,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      visibleTo: visibleTo ?? this.visibleTo,
      seenBy: seenBy ?? this.seenBy,
      type: type ?? this.type,
      image: image ?? this.image,
    );
  }
}

enum MessageType {
  // type 0
  Text,
  // type 1
  Image,
  // type 2
  Voice,
  // type 3
  Video,
  // type 4
  Emoji,
  // type 5
  GIF,
  // type 6
  Sticker,
}
