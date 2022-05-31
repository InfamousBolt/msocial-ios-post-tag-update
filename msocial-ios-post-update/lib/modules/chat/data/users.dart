import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../imports.dart';
import '../../auth/data/user.dart';

mixin ChatUsersRepository {
  static DocumentSnapshot? lastMemDoc;

  static Future<List<User>> fetchAllUsers(int page) async {
    var query =
        UserRepository.usersCol.orderBy('activeAt', descending: true).limit(20);

    if (lastMemDoc != null && page != 0) {
      query = query.startAfterDocument(lastMemDoc!);
    }
    final docs = (await query.get()).docs;
    if (docs.isEmpty) return [];
    lastMemDoc = docs.last;
    return [for (final d in docs) d.data()];
  }

  static Stream<List<User>> onlineUsers() => UserRepository.usersCol
      .where(
        'activeAt',
        isGreaterThan: DateTime.now().subtract(Duration(minutes: 30)),
      )
      .where('onlineStatus', isEqualTo: true)
      .orderBy('activeAt', descending: true)
      .limit(20)
      .snapshots()
      .map((e) => [for (final d in e.docs) d.data()])
      .map(
        (e) => [
          for (final u in e)
            if (!u.isMe && !u.isBanned && u.isActive) u
        ],
      )
      .handleError((e) => logError(e));

  static Future<List<User>> usersSearch(String query) async {
    final docs = await UserRepository.usersCol
        .where('searchIndexes', arrayContains: query.toLowerCase())
        .limit(10)
        .get();

    return [for (final g in docs.docs) g.data()];
  }
}
