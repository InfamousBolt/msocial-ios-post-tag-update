/*
 * Generated file. Do not edit.
 *
 * Locales: 1
 * Strings: 178 
 *
 * Built on 2022-02-21 at 10:29 UTC
 */

import 'package:flutter/widgets.dart';

const AppLocale _baseLocale = AppLocale.en;
AppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale {
  en, // 'en' (base locale, fallback)
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn _t = _currLocale.translations;
_StringsEn get t => _t;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
  Translations._(); // no constructor

  static _StringsEn of(BuildContext context) {
    final inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
    if (inheritedWidget == null) {
      throw 'Please wrap your app with "TranslationProvider".';
    }
    return inheritedWidget.translations;
  }
}

class LocaleSettings {
  LocaleSettings._(); // no constructor

  /// Uses locale of the device, fallbacks to base locale.
  /// Returns the locale which has been set.
  static AppLocale useDeviceLocale() {
    final locale = AppLocaleUtils.findDeviceLocale();
    return setLocale(locale);
  }

  /// Sets locale
  /// Returns the locale which has been set.
  static AppLocale setLocale(AppLocale locale) {
    _currLocale = locale;
    _t = _currLocale.translations;

    if (WidgetsBinding.instance != null) {
      // force rebuild if TranslationProvider is used
      _translationProviderKey.currentState?.setLocale(_currLocale);
    }

    return _currLocale;
  }

  /// Sets locale using string tag (e.g. en_US, de-DE, fr)
  /// Fallbacks to base locale.
  /// Returns the locale which has been set.
  static AppLocale setLocaleRaw(String rawLocale) {
    final locale = AppLocaleUtils.parse(rawLocale);
    return setLocale(locale);
  }

  /// Gets current locale.
  static AppLocale get currentLocale {
    return _currLocale;
  }

  /// Gets base locale.
  static AppLocale get baseLocale {
    return _baseLocale;
  }

  /// Gets supported locales in string format.
  static List<String> get supportedLocalesRaw {
    return AppLocale.values.map((locale) => locale.languageTag).toList();
  }

  /// Gets supported locales (as Locale objects) with base locale sorted first.
  static List<Locale> get supportedLocales {
    return AppLocale.values.map((locale) => locale.flutterLocale).toList();
  }
}

/// Provides utility functions without any side effects.
class AppLocaleUtils {
  AppLocaleUtils._(); // no constructor

  /// Returns the locale of the device as the enum type.
  /// Fallbacks to base locale.
  static AppLocale findDeviceLocale() {
    final String? deviceLocale =
        WidgetsBinding.instance?.window.locale.toLanguageTag();
    if (deviceLocale != null) {
      final typedLocale = _selectLocale(deviceLocale);
      if (typedLocale != null) {
        return typedLocale;
      }
    }
    return _baseLocale;
  }

  /// Returns the enum type of the raw locale.
  /// Fallbacks to base locale.
  static AppLocale parse(String rawLocale) {
    return _selectLocale(rawLocale) ?? _baseLocale;
  }
}

// context enums

// interfaces generated as mixins

// translation instances

late _StringsEn _translationsEn = _StringsEn.build();

// extensions for AppLocale

extension AppLocaleExtensions on AppLocale {
  /// Gets the translation instance managed by this library.
  /// [TranslationProvider] is using this instance.
  /// The plural resolvers are set via [LocaleSettings].
  _StringsEn get translations {
    switch (this) {
      case AppLocale.en:
        return _translationsEn;
    }
  }

  /// Gets a new translation instance.
  /// [LocaleSettings] has no effect here.
  /// Suitable for dependency injection and unit tests.
  ///
  /// Usage:
  /// final t = AppLocale.en.build(); // build
  /// String a = t.my.path; // access
  _StringsEn build() {
    switch (this) {
      case AppLocale.en:
        return _StringsEn.build();
    }
  }

  String get languageTag {
    switch (this) {
      case AppLocale.en:
        return 'en';
    }
  }

  Locale get flutterLocale {
    switch (this) {
      case AppLocale.en:
        return const Locale.fromSubtags(languageCode: 'en');
    }
  }
}

extension StringAppLocaleExtensions on String {
  AppLocale? toAppLocale() {
    switch (this) {
      case 'en':
        return AppLocale.en;
      default:
        return null;
    }
  }
}

// wrappers

GlobalKey<_TranslationProviderState> _translationProviderKey =
    GlobalKey<_TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
  TranslationProvider({required this.child})
      : super(key: _translationProviderKey);

  final Widget child;

  @override
  _TranslationProviderState createState() => _TranslationProviderState();

  static _InheritedLocaleData of(BuildContext context) {
    final inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
    if (inheritedWidget == null) {
      throw 'Please wrap your app with "TranslationProvider".';
    }
    return inheritedWidget;
  }
}

class _TranslationProviderState extends State<TranslationProvider> {
  AppLocale locale = _currLocale;

  void setLocale(AppLocale newLocale) {
    setState(() {
      locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedLocaleData(
      locale: locale,
      child: widget.child,
    );
  }
}

class _InheritedLocaleData extends InheritedWidget {
  final AppLocale locale;
  Locale get flutterLocale => locale.flutterLocale; // shortcut
  final _StringsEn translations; // store translations to avoid switch call

  _InheritedLocaleData({required this.locale, required Widget child})
      : translations = locale.translations,
        super(child: child);

  @override
  bool updateShouldNotify(_InheritedLocaleData oldWidget) {
    return oldWidget.locale != locale;
  }
}

// pluralization feature not used

// helpers

final _localeRegex =
    RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
AppLocale? _selectLocale(String localeRaw) {
  final match = _localeRegex.firstMatch(localeRaw);
  AppLocale? selected;
  if (match != null) {
    final language = match.group(1);
    final country = match.group(5);

    // match exactly
    selected = AppLocale.values.cast<AppLocale?>().firstWhere(
        (supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'),
        orElse: () => null);

    if (selected == null && language != null) {
      // match language
      selected = AppLocale.values.cast<AppLocale?>().firstWhere(
          (supported) => supported?.languageTag.startsWith(language) == true,
          orElse: () => null);
    }

    if (selected == null && country != null) {
      // match country
      selected = AppLocale.values.cast<AppLocale?>().firstWhere(
          (supported) => supported?.languageTag.contains(country) == true,
          orElse: () => null);
    }
  }
  return selected;
}

// translations

// Path: <root>
class _StringsEn {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  _StringsEn.build();

  /// Access flat map
  dynamic operator [](String key) => _flatMap[key];

  // Internal flat map initialized lazily
  late final Map<String, dynamic> _flatMap = _buildFlatMap();

  // ignore: unused_field
  late final _StringsEn _root = this;

  // Translations
  String get About => 'About';
  String get AboutApp =>
      'An awesome community for mothers';
  String get AcceptTerms => 'I Accept All Terms & Conditions / EULA';
  String get Account => 'Account';
  String get AddGroupName => 'Please! Add Group Name';
  String get AddMembers => 'Add Members';
  String get AddSomeContent => '\'Please add some content before posting\'';
  String get AddValidFirstName => 'Add a valid first name';
  String get AddValidLastName => 'Add a valid last name';
  String get AddValidUsername => 'Add a valid username';
  String get AddWallpaper => 'Add Wallpaper';
  String get Admin => 'Admin';
  String get AllChats => 'All Chats';
  String get Announcement => 'Announcement';
  String get AppName => 'MSocial';
  String get AppVersion => '1.0.0';
  String get AreYouSure => 'Are you sure to';
  String get Ban => 'Ban';
  String get Banned => 'Banned';
  String get Block => 'Block';
  String get Both => 'Both';
  String get Camera => 'Camera';
  String get Cancel => 'Cancel';
  String get CannotChatWithUser => 'Sorry! You can\'t chat wih this user';
  String get CannotFindFile => 'Oops! Cannot find the file';
  String get Categories => 'Categories';
  String get Category => 'Category';
  String get Chats => 'Chats';
  String get CommentReactedMsg => 'reacted to your comment';
  String get CommentRemoveConfirm =>
      'Are you sure you want to delete this comment?';
  String get Comments => 'Comments';
  String get ConfirmChatDeletion => 'Are you sure to delete chat';
  String get Copied => 'Copied';
  String get Copy => 'Copy';
  String get CreateGroup => 'Create a Group';
  String get CreatePost => 'Create Post';
  String get Delete => 'Delete';
  String get DidntRecieveCode => 'Didn\'t receive the code? ';
  String get DirectMsgs => 'Direct Messages';
  String get DirectMsgsDescr => 'Recieve all Direct Chat Notificatins';
  String get Downloading => 'Downloading';
  String get EULA => 'EULA Agreement';
  String get Edit => 'Edit';
  String get EditGroup => 'Edit your Group';
  String get EditProfile => 'Edit Profile';
  String get Email => 'Email';
  String get EmailUser => 'Are you Email User, Login here!';
  String get Emoji => 'Emoji';
  String get EnterCode => 'Enter the code sent to ';
  String get FOLLOWERS => 'FOLLOWERS';
  String get FOLLOWINGS => 'FOLLOWINGS';
  String get FailedToUpload => 'Oops! Upload Failed, Please try again';
  String get Favorites => 'Favorites';
  String get Feed => 'MFeed';
  String get Female => 'Female';
  String get FirstName => 'First Name';
  String get Follow => 'Follow';
  String get Following => 'Following';
  String get FullName => 'Full Name';
  String get GIF => 'GIF';
  String get Gallery => 'Gallery';
  String get Group => 'Group';
  String get GroupName => 'Group Name';
  String get GroupType => 'Group Type';
  String get Groups => 'Groups';
  String get GroupsMsgs => 'Groups Messages';
  String get GroupsMsgsDesc => 'Recieve all Groups Notifications';
  String get Home => 'Home';
  String get Hot => 'Hot';
  String get Image => 'Image';
  String get InvalidEmail => 'Invalid Email';
  String get InvalidPhone => 'Please fill up all the cells properly';
  String get InvalidSMSCode => 'The SMS Verification Code is Invalid';
  String get Join => 'Join';
  String get Joined => 'Joined';
  String get LastName => 'Last Name';
  String get LeaveGroup => 'Leave Group';
  String get Likes => 'Likes';
  String get Lock => 'Lock';
  String get Login => 'Login';
  String get LoginFirst => 'Oops, Please login first';
  String get Logout => 'Logout';
  String get Male => 'Male';
  String get Members => 'Members';
  String get Message => 'Message';
  String get Messaging => 'Message...';
  String get MostDownloaded => 'Most Downloaded';
  String get MsgDeleteConfirm => 'Are you sure you want to delete the message?';
  String get MyPosts => 'My Posts';
  String get New => 'New';
  String get Newest => 'Newest';
  String get Next => 'Next';
  String get NoChatFound => 'No Recents chat yet, start chatting!';
  String get NoFilePicked => 'Trying to upload and no file is picked';
  String get NoImgSelected => 'No Image Selected';
  String get NoInternet => 'No Internet Access';
  String get NoWallpaperSelectedMsg => 'Please Select Wallpaper to continue';
  String get NotAllowedToComment => 'Sorry! You are not allowed to comment';
  String get NotAllowedToPublish =>
      'Sorry! You are not allowed to publish anymore';
  String get Notifications => 'Notifications';
  String get Off => 'Off';
  String get On => 'On';
  String get Online => 'Online';
  String get OnlineDescription => 'Anyone can see when you\'re last Online';
  String get OnlineStatus => 'Online Status';
  String get OnlineUsers => 'Online users';
  String get Other => 'Other';
  String get POSTS => 'POSTS';
  String get Password => 'Password';
  String get PhoneNumber => 'Phone Number';
  String get PhoneVerification => 'Phone Number Verification';
  String get PhotosLibrary => 'Photos Library';
  String get Post => 'Post';
  String get PostCommentMsg => 'commented your post';
  String get PostReactionMsg => 'reacted to your post';
  String get PostRemoveConfirm => 'Are you sure you want to delete this post?';
  String get PrivacyPolicy => 'Privacy Policy';
  String get Private => 'Private';
  String get ProfanityDetected =>
      'Bad words detected, your account may get suspended!';
  String get Profile => 'Profile';
  String get Public => 'Public';
  String get RESEND => 'RESEND';
  String get RateUs => 'Rate Us';
  String get ReadMore => '...Read More';
  String get RecentChats => 'Recent chats';
  String get RecordVideo => 'Record Video';
  String get Register => 'Register';
  String get RemoveConversation => 'Remove Conversation';
  String get RemoveMember => 'Remove member';
  String get Replies => 'Replies';
  String get Reply => 'Reply';
  String get ReplyMsg => 'replied to your comment';
  String get Report => 'Report';
  String get ReportDesc => 'We remove post that has: ';
  String get ReportNote => "We won't let them know if you take this action.";
  String get ReportReasons =>
      '⚫️ Sexual content. \n\n⚫️ Violent or repulsive content. \n\n⚫️ Hateful or abusive content. \n\n⚫️ Spam or misleading.';
  String get ReportThanks =>
      'We will check your request, Thanks for helping improve our community';
  String get ReportedPosts => 'Reported Posts';
  String get START => 'GET STARTED';
  String get Save => 'Save';
  String get Search => 'Search';
  String get Searching => 'Searching...';
  String get SelectGender => 'Please select your gender.';
  String get SelectPhoneCode => 'Select a phone code';
  String get SentYouMsg => 'Sent you message';
  String get SetAsWallpaper => 'Set as Wallpaper';
  String get Settings => 'Settings';
  String get Share => 'Share';
  String get ShortPassword => 'Password Must Contain At Least 8 characters';
  String get SlideToCancel => 'Slide to cancel';
  String get StartFollowingMsg => 'started following you';
  String get Status => 'Status';
  String get Sticker => 'Sticker';
  String get Stories => 'Stories';
  String get SuccessPostEdited => 'Post has been edited Successfully';
  String get SuccessPostPublish => 'Post has been published Successfully';
  String get TakePicture => 'Take Picture';
  String get Top => 'Top';
  String get Trending => 'Trending';
  String get TypeComment => 'Type a comment...';
  String get Typing => 'Typing...';
  String get Unban => 'Unban';
  String get Unblock => 'UnBlock';
  String get UnknownError => 'Oops, Something went Wrong!';
  String get Unreport => 'Unreport';
  String get Upload => 'Upload';
  String get UploadFinished => 'Upload Finished';
  String get Username => 'Username';
  String get UsernameTaken => 'Username is Already taken';
  String get Users => 'Users';
  String get VERIFY => 'VERIFY';
  String get Video => 'Video';
  String get VideosLibrary => 'Videos Library';
  String get Voice => 'Voice';
  String get WallpaperName => 'Wallpaper Name';
  String get WallpaperSet => 'Wallpaper Set Successfully';
  String get Wallpapers => 'Wallpapers';
  String get WhatOnMind => "What do you want to ask or share? 😉";
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
  Map<String, dynamic> _buildFlatMap() {
    return {
      'About': 'About',
      'AboutApp':
          'Social Messenger is a community dedicated to chat app to connect people.',
      'AcceptTerms': 'I Accept All Terms & Conditions',
      'Account': 'Account',
      'AddGroupName': 'Please! Add Group Name',
      'AddMembers': 'Add Members',
      'AddSomeContent': '\'Please add some content before posting\'',
      'AddValidFirstName': 'Add a valid first name',
      'AddValidLastName': 'Add a valid last name',
      'AddValidUsername': 'Add a valid username',
      'AddWallpaper': 'Add Wallpaper',
      'Admin': 'Admin',
      'AllChats': 'All Chats',
      'Announcement': 'Announcement',
      'AppName': 'Social Messenger',
      'AppVersion': '2.0.0',
      'AreYouSure': 'Are you sure to',
      'Ban': 'Ban',
      'Banned': 'Banned',
      'Block': 'Block',
      'Both': 'Both',
      'Camera': 'Camera',
      'Cancel': 'Cancel',
      'CannotChatWithUser': 'Sorry! You can\'t chat wih this user',
      'CannotFindFile': 'Oops! Cannot find the file',
      'Categories': 'Categories',
      'Category': 'Category',
      'Chats': 'Chats',
      'CommentReactedMsg': 'reacted to your comment',
      'CommentRemoveConfirm': 'Are you sure you want to delete this comment?',
      'Comments': 'Comments',
      'ConfirmChatDeletion': 'Are you sure to delete chat',
      'Copied': 'Copied',
      'Copy': 'Copy',
      'CreateGroup': 'Create a Group',
      'CreatePost': 'Create Post',
      'Delete': 'Delete',
      'DidntRecieveCode': 'Didn\'t receive the code? ',
      'DirectMsgs': 'Direct Messages',
      'DirectMsgsDescr': 'Recieve all Direct Chat Notificatins',
      'Downloading': 'Downloading',
      'EULA': 'EULA Agreement',
      'Edit': 'Edit',
      'EditGroup': 'Edit your Group',
      'EditProfile': 'Edit Profile',
      'Email': 'Email',
      'EmailUser': 'Are you Email User, Login here!',
      'Emoji': 'Emoji',
      'EnterCode': 'Enter the code sent to ',
      'FOLLOWERS': 'FOLLOWERS',
      'FOLLOWINGS': 'FOLLOWINGS',
      'FailedToUpload': 'Oops! Upload Failed, Please try again',
      'Favorites': 'Favorites',
      'Feed': 'FeeD',
      'Female': 'Female',
      'FirstName': 'First Name',
      'Follow': 'Follow',
      'Following': 'Following',
      'FullName': 'Full Name',
      'GIF': 'GIF',
      'Gallery': 'Gallery',
      'Group': 'Group',
      'GroupName': 'Group Name',
      'GroupType': 'Group Type',
      'Groups': 'Groups',
      'GroupsMsgs': 'Groups Messages',
      'GroupsMsgsDesc': 'Recieve all Groups Notifications',
      'Home': 'Home',
      'Hot': 'Hot',
      'Image': 'Image',
      'InvalidEmail': 'Invalid Email',
      'InvalidPhone': 'Please fill up all the cells properly',
      'InvalidSMSCode': 'The SMS Verification Code is Invalid',
      'Join': 'Join',
      'Joined': 'Joined',
      'LastName': 'Last Name',
      'LeaveGroup': 'Leave Group',
      'Likes': 'Likes',
      'Lock': 'Lock',
      'Login': 'Login',
      'LoginFirst': 'Oops, Please login first',
      'Logout': 'Logout',
      'Male': 'Male',
      'Members': 'Members',
      'Message': 'Message',
      'Messaging': 'Message...',
      'MostDownloaded': 'Most Downloaded',
      'MsgDeleteConfirm': 'Are you sure you want to delete the message?',
      'MyPosts': 'My Posts',
      'New': 'New',
      'Newest': 'Newest',
      'Next': 'Next',
      'NoChatFound': 'No Recents chat yet, start chatting!',
      'NoFilePicked': 'Trying to upload and no file is picked',
      'NoImgSelected': 'No Image Selected',
      'NoInternet': 'No Internet Access',
      'NoWallpaperSelectedMsg': 'Please Select Wallpaper to continue',
      'NotAllowedToComment': 'Sorry! You are not allowed to comment',
      'NotAllowedToPublish': 'Sorry! You are not allowed to publish anymore',
      'Notifications': 'Notifications',
      'Off': 'Off',
      'On': 'On',
      'Online': 'Online',
      'OnlineDescription': 'Anyone can see when you\'re last Online',
      'OnlineStatus': 'Online Status',
      'OnlineUsers': 'ONLINE USERS',
      'Other': 'Other',
      'POSTS': 'POSTS',
      'Password': 'Password',
      'PhoneNumber': 'Phone Number',
      'PhoneVerification': 'Phone Number Verification',
      'PhotosLibrary': 'Photos Library',
      'Post': 'Post',
      'PostCommentMsg': 'commented your post',
      'PostReactionMsg': 'reacted to your post',
      'PostRemoveConfirm': 'Are you sure you want to delete this post?',
      'PrivacyPolicy': 'Privacy Policy',
      'Private': 'Private',
      'ProfanityDetected':
          'Bad words detected, your account may get suspended!',
      'Profile': 'Profile',
      'Public': 'Public',
      'RESEND': 'RESEND',
      'RateUs': 'Rate Us',
      'ReadMore': '...Read More',
      'RecentChats': 'RECENT CHATS',
      'RecordVideo': 'Record Video',
      'Register': 'Register',
      'RemoveConversation': 'Remove Conversation',
      'RemoveMember': 'Remove member',
      'Replies': 'Replies',
      'Reply': 'Reply',
      'ReplyMsg': 'replied to your comment',
      'Report': 'Report',
      'ReportDesc': 'We remove post that has: ',
      'ReportNote': 'We wont let them know if you take this action.',
      'ReportReasons':
          '⚫️ Sexual content. \n\n⚫️ Violent or repulsive content. \n\n⚫️ Hateful or abusive content. \n\n⚫️ Spam or misleading.',
      'ReportThanks':
          'We will check your request, Thanks for helping improve our community',
      'ReportedPosts': 'Reported Posts',
      'START': 'GET STARTED',
      'Save': 'Save',
      'Search': 'Search',
      'Searching': 'Searching...',
      'SelectGender': 'Please select your gender.',
      'SelectPhoneCode': 'Select a phone code',
      'SentYouMsg': 'Sent you message',
      'SetAsWallpaper': 'Set as Wallpaper',
      'Settings': 'Settings',
      'Share': 'Share',
      'ShortPassword': 'Password Must Contain At Least 8 characters',
      'SlideToCancel': 'Slide to cancel',
      'StartFollowingMsg': 'start following you',
      'Status': 'Status',
      'Sticker': 'Sticker',
      'Stories': 'Stories',
      'SuccessPostEdited': 'Post has been edited Successfully',
      'SuccessPostPublish': 'Post has been published Successfully',
      'TakePicture': 'Take Picture',
      'Top': 'Top',
      'Trending': 'Trending',
      'TypeComment': 'Type a comment...',
      'Typing': 'Typing...',
      'Unban': 'Unban',
      'Unblock': 'UnBlock',
      'UnknownError': 'Oops, Something went Wrong!',
      'Unreport': 'Unreport',
      'Upload': 'Upload',
      'UploadFinished': 'Upload Finished',
      'Username': 'Username',
      'UsernameTaken': 'Username is Already taken',
      'Users': 'Users',
      'VERIFY': 'VERIFY',
      'Video': 'Video',
      'VideosLibrary': 'Videos Library',
      'Voice': 'Voice',
      'WallpaperName': 'Wallpaper Name',
      'WallpaperSet': 'Wallpaper Set Successfully',
      'Wallpapers': 'Wallpapers',
      'WhatOnMind': 'What on your mind?',
    };
  }
}
