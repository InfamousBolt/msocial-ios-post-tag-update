import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../imports.dart';
import '../models/chat.dart';
import 'chats.dart';

mixin MessagesRepository {
  static String get _uid => authProvider.user!.id;

  static CollectionReference<Message> msgsCol(String? chatId) =>
      ChatsRepository.chatDoc(chatId)
          .collection('messages')
          .withConverter<Message>(
            fromFirestore: (m, _) => Message.fromMap(m.data()!),
            toFirestore: (m, _) => m.toMap(),
          );

  static DocumentReference<Message> msgDoc(String? chatId, String msgId) =>
      msgsCol(chatId).doc(msgId);

  static Future<void> sendMessage(Message msg) async {
    try {
      final doc = await ChatsRepository.chatDoc(msg.chatID).get();
      //Create new chat document --> first discussion
      if (doc.data() == null) {
        await doc.reference
            .withConverter<Chat>(
              fromFirestore: (m, _) => Chat.fromMap(m.data()!),
              toFirestore: (m, _) => m.toMap()
                ..['updatedAt'] = FieldValue.serverTimestamp()
                ..['createdAt'] = FieldValue.serverTimestamp(),
            )
            .set(Chat.fromMessage(msg));
      } else {
        await doc.reference.update({
          'updatedAt': FieldValue.serverTimestamp(),
          'visibleTo': msg.visibleTo
        });
      }
      final _msgDocRef = await msgDoc(msg.chatID, msg.id).get();
      if (_msgDocRef.exists) {
        _msgDocRef.reference.update({
          'content': msg.content,
          'seenBy': msg.seenBy,
          'visibleTo': msg.visibleTo,
          if (msg.isImage) 'image': msg.image!.toMap(),
        });
      } else {
        _msgDocRef.reference
            .withConverter<Message>(
              fromFirestore: (m, _) => Message.fromMap(m.data()!),
              toFirestore: (m, _) =>
                  m.toMap()..['createdAt'] = FieldValue.serverTimestamp(),
            )
            .set(msg);
      }
    } catch (e) {
      logError(e);
    }
  }

  static Future<void> editMessage(Message msg) async {
    await msgDoc(msg.chatID, msg.id).update({'content': msg.content});
  }

  static Future<void> deleteMessage({
    required String chatId,
    required String msgId,
  }) async {
    await msgDoc(chatId, msgId).delete();
  }

  static Stream<List<Message>> msgsStream(String chatID, int limit) =>
      msgsCol(chatID)
          .orderBy('createdAt', descending: true)
          .where('visibleTo', arrayContains: _uid)
          .limit(limit)
          .snapshots()
          .map(
            (s) => [
              for (final doc in s.docs)
                if (doc.exists) doc.data()
            ],
          )
          .map(
            (s) => [
              for (final m in s)
                if (m.isSent || m.isSending) m
            ],
          )
          .handleError((e) => logError(e));

  static void updateSeenBy(List<Message> msgs) {
    for (final m in msgs) {
      if (m.isFromMe || m.isSeenByMe || !m.isSent) continue;
      msgDoc(m.chatID, m.id).update({
        'seenBy': FieldValue.arrayUnion([_uid])
      }).catchError((e) => logError(e));
    }
  }
}
