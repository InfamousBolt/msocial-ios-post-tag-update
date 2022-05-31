import '../../imports.dart';
import 'models/group.dart';
import 'pages/chats/index.dart';
import 'pages/chats/users_search.dart';
import 'pages/conversation/group.dart';
import 'pages/conversation/private.dart';
import 'pages/groups/editor.dart';
import 'pages/groups/group_info.dart';
import 'pages/groups/members.dart';
import 'pages/groups/search.dart';

mixin ChatRoutes {
  static Future<void> toChats() async {
    Get.find<AdsHelper>().loadFullAds();
    await Get.to(() => ChatsPage());
    Get.find<AdsHelper>().showFullAds();
  }

  static Future<void> toPrivateChat(String userId) async {
    appPrefs.page = AppPage.chatting(userId);
    await Get.to(() => PrivateChatPage(userId));
    appPrefs.page = AppPage.others();
  }

  static void toUsersSearchPage() => Get.to(() => UsersSearchPage());

  //Groups Module
  static Future<void> toGroupChat(String id) async {
    Get.find<AdsHelper>().loadFullAds();
    appPrefs.page = AppPage.groupChatting(id);
    await Get.to(() => GroupChatPage(id));
    appPrefs.page = AppPage.others();
    Get.find<AdsHelper>().showFullAds();
  }

  static Future<void> toGroupEditor([Group? toEdit]) async =>
      Get.to(() => GroupEditor(toEditGroup: toEdit));
  static Future<void> toGroupInfo(Group group) async =>
      Get.to(() => GroupInfoPage(group));
  static Future<void> toGroupMembers(Group group) async =>
      Get.to(() => GroupMembersPage(group));
  static Future<void> toGroupsSearch() async => Get.to(() => GroupsSearch());
}
