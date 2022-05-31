import 'package:firebase_auth/firebase_auth.dart' hide User;

import '../../../imports.dart';
import 'user.dart';

mixin RegisterRepository {
  static Future<void> createNewUser({
    required String username,
    required String firstName,
    required String lastName,
    String? email,
    String? photoURL,
    String? gender,
  }) async {
    final doc = await UserRepository.userDoc().get();
    if (doc.exists) return;
    final fUser = FirebaseAuth.instance.currentUser!;
    final _user = User.createNew(
      uid: fUser.uid,
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email ?? fUser.email,
      phone: fUser.phoneNumber ?? '',
      photoURL: photoURL ?? fUser.photoURL,
      country: appPrefs.prefs.getString('country'),
      gender: gender,
    );
    if (!doc.exists) await doc.reference.set(_user);
    fUser
      ..updatePhotoURL(_user.photoURL)
      ..updateDisplayName(_user.username);

    if (_user.email.isNotEmpty) {
      fUser.updateEmail(_user.email);
    }
  }

  static Future<String> login(String email, String password) async {
    final fUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return fUser.user!.uid;
  }

  static Future<bool> checkIfUsernameTaken(String username) async {
    final result = await UserRepository.usersCol
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isNotEmpty;
  }

  static Future<bool> checkIfEmailTaken(String email) async {
    final res = await UserRepository.usersCol
        .where(
          'email',
          isEqualTo: email,
        )
        .get();
    return res.docs.isNotEmpty;
  }
}
