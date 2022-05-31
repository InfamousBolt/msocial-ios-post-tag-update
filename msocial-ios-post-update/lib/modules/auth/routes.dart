import '../../imports.dart';
import 'pages/email/index.dart';
import 'pages/phone/index.dart';
import 'pages/profile/editor.dart';
import 'pages/profile/index.dart';
import 'pages/register/index.dart';

mixin AuthRoutes {
  static Future<void>? toPhoneLogin() => Get.to(
        () => GetPlatform.isMacOS && !GetPlatform.isWeb
            ? EmailLoginPage()
            : PhoneLoginPage(),
      );
  static Future<void>? toEditProfile() => Get.to(() => EditProfilePage());
  static Future<void>? toProfile([String? userID]) =>
      Get.to(() => ProfilePage(userID: userID), preventDuplicates: false);
  static Future<void>? toRegister() => Get.to(() => RegisterPage());
}
