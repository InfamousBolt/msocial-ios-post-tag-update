import 'package:firebase_storage/firebase_storage.dart';

mixin StorageHelper {
  static final storage = FirebaseStorage.instance;
  //----------- Profiles -------------------------------------------------
  static final _profilesStorage = storage.ref().child('profiles');
  static final profilesPicRef = _profilesStorage.child('pictures');
  static final profilesCoverRef = _profilesStorage.child('covers');

  //----------- Posts -------------------------------------------------
  static final _postsStorage = storage.ref().child('posts');
  static final postsImageRef = _postsStorage.child('images');
  static final postsVideoRef = _postsStorage.child('videos');

  //----------- Chats -------------------------------------------------
  static final _chatsStorage = storage.ref().child('chats');
  static final chatImagesRef = _chatsStorage.child('images');
  static final chatVideosRef = _chatsStorage.child('video');
  static final chatSoundsRef = _chatsStorage.child('sounds');

  //----------- Posts -------------------------------------------------
  static Reference groupRef(String name) =>
      storage.ref().child('groups/').child(name);
  static Reference groupImagesRef(String name) =>
      groupRef(name).child('images');
  static Reference groupVideosRef(String name) =>
      groupRef(name).child('videos');
  static Reference groupSoundsRef(String name) =>
      groupRef(name).child('sounds');

  //----------- Wallpapers -------------------------------------------------
  static final wallpaperseRef = storage.ref().child('wallpapers/');
}
