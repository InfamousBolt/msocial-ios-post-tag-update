import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../imports.dart';
import '../models/chat.dart';
import 'chat_msgs.dart';

mixin ChatsRepository {
  static String get _uid => authProvider.user!.id;

  static final _firestore = FirebaseFirestore.instance;
  static final chatCol = _firestore.collection('chats').withConverter<Chat>(
        fromFirestore: (m, _) => Chat.fromMap(m.data()!),
        toFirestore: (m, _) => m.toMap(),
      );
  static DocumentReference<Chat> chatDoc(String? chatId) => chatCol.doc(chatId);

  static Stream<List<Chat>> chatsStream(int limit) => chatCol
      .where('visibleTo', arrayContains: _uid)
      .orderBy('updatedAt', descending: true)
      .limit(limit)
      .snapshots()
      .map(
        (e) => [
          for (final doc in e.docs) doc.data(),
        ],
      )
      .handleError((e) => logError(e));

  static Stream<Chat?> chatStream(String id) => chatDoc(id)
      .snapshots()
      .map((e) => e.data())
      .handleError((e) => logError(e));

  static Future<void> removeChat(String userId) async {
    final chatId = Chat.getChatId(userId);
    await ChatsRepository.chatDoc(chatId).update({
      'visibleTo': FieldValue.arrayRemove([_uid]),
      'typing': []
    });
    final docs = await MessagesRepository.msgsCol(chatId).get();
    for (final doc in docs.docs) {
      await doc.reference.update({
        'visibleTo': FieldValue.arrayRemove([_uid])
      });
    }
  }

  static Future<void> toggleTyping(String? chatID, bool isTyping) async {
    if (chatID == null) return;
    await ChatsRepository.chatDoc(chatID).update({
      'typing': isTyping
          ? FieldValue.arrayUnion([_uid])
          : FieldValue.arrayRemove([_uid])
    });
  }
}
