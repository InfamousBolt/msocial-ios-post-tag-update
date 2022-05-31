import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/models/Business.dart';
import '../../imports.dart';
import '../../modules/auth/data/user.dart';
import 'about.dart';

Future<void>? toSettingsPage() => Get.to(() => SettingsPage());

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User user = authProvider.user!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        titleStr: t.Settings,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SettingsSection(
                title: t.Account,
                tiles: [
                  SettingsTile(
                    title: t.EditProfile,
                    leading: Icon(Icons.person),
                    onPressed: (_) => AuthRoutes.toEditProfile(),
                  ),
                  SettingsTile.switchTile(
                    title: t.OnlineStatus,
                    subtitle: t.OnlineDescription,
                    leading: Icon(
                      user.onlineStatus
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    switchValue: user.onlineStatus,
                    onToggle: (v) {
                      setState(() => user = user.copyWith(onlineStatus: v));
                    },
                  ),
                  // SettingsTile.switchTile(
                  //   title: 'Dark Mode',
                  //   leading: Icon(FontAwesomeIcons.moon),
                  //   switchValue: appPrefs.isDarkMode(),
                  //   onToggle: (_){},
                  // ),
                  SettingsTile(
                    title: t.Logout,
                    leading: Icon(FontAwesomeIcons.powerOff),
                    onPressed: (_) async {
                      await save();
                      await authProvider.logout();
                    },
                  ),
                ],
              ),
            SettingsSection(
              title: t.Notifications,
              tiles: [
                SettingsTile.switchTile(
                  title: t.DirectMsgs,
                  subtitle: t.DirectMsgsDescr,
                  leading: Icon(
                    user.chatNotify
                        ? Icons.notifications_active
                        : Icons.notifications_off,
                  ),
                  switchValue: user.chatNotify,
                  onToggle: (v) {
                    user = user.copyWith(chatNotify: v);
                    setState(() {});
                  },
                ),
                SettingsTile.switchTile(
                  title: t.GroupsMsgs,
                  subtitle: t.GroupsMsgsDesc,
                  leading: Icon(
                    user.groupsNotify
                        ? Icons.notifications_active
                        : Icons.notifications_off,
                  ),
                  switchValue: user.groupsNotify,
                  onToggle: (v) {
                    user = user.copyWith(groupsNotify: v);
                    setState(() {});
                  },
                ),
              ],
            ),
            ListTile(
              title: Text(t.About),
              leading: Icon(Icons.help_outline),
              onTap: toAboutPage,
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              title: Text("Are you a Business?"),
              leading: Icon(Icons.business_center),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Business()),
                );
              },
              trailing: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    save();
    super.dispose();
  }

  Future<void> save() async {
    if (user == authProvider.user) return;
    await 1.delay();
    authProvider.rxUser(user);
    await UserRepository.saveMyInfo();
  }
}
