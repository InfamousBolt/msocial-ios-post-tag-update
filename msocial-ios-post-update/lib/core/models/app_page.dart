import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_page.freezed.dart';

@freezed
class AppPage with _$AppPage {
  const factory AppPage.chatting(String userId) = _Chatting;
  const factory AppPage.groupChatting(String groupId) = _GroupChatting;
  const factory AppPage.commenting(String postID) = _Commenting;
  const factory AppPage.others() = _Others;
}
