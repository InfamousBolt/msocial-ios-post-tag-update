import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../imports.dart';
import '../modules/admin/admin.dart';
import '../modules/chat/pages/groups/groups_list.dart';
import '../modules/notifications/pages/index.dart';
import 'settings/settings.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Container(
        height: context.height,
        color: Colors.white,
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _DrawerMenu(),
              Expanded(
                child: Obx(
                  () => IndexedStack(
                    index: appPrefs.drawerState().index,
                    children: <Widget>[
                      GroupsListPage(),
                      NotificationScreen(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 75,
      color: Color.fromRGBO(245, 199, 192, 1.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          MenuItem(
            icon: Icon(Icons.group),
            title: t.GroupsMsgs,
            drawerState: DrawerState.GROUPS,
            action: () => appPrefs.drawerState(DrawerState.GROUPS),
          ),
          Container(
            color: theme.secondaryHeaderColor,
            height: 2,
            width: 48,
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
          MenuItem(
            icon: Badge(child: Icon(Icons.notifications)),
            title: t.Notifications,
            drawerState: DrawerState.Notifications,
            action: () => appPrefs.drawerState(DrawerState.Notifications),
          ),
          Container(
            color: theme.primaryColorDark,
            height: 2,
            width: 48,
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
          if (authProvider.user!.isAdmin) ...[
            MenuItem(
              icon: Icon(FontAwesomeIcons.lock),
              title: t.Admin,
              action: toAdminPage,
            ),
            Container(
              color: theme.primaryColorDark,
              height: 2,
              width: 48,
              margin: EdgeInsets.symmetric(vertical: 8),
            ),
          ],
          Spacer(),
          // Obx(
          //   () => DayNightSwitcherIcon(
          //     isDarkModeEnabled: !appPrefs.isDarkMode(),
          //     onStateChanged: (_) => appPrefs.changeThemeMode(),
          //   ),
          // ),
          SizedBox(height: 10),
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {
              Navigator.pop(context);
              AuthRoutes.toProfile();
            },
          ),
          SizedBox(height: 10),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pop(context);
              toSettingsPage();
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final VoidCallback? action;
  final DrawerState? drawerState;

  const MenuItem({
    Key? key,
    this.icon,
    this.action,
    this.drawerState,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final color = context.theme.scaffoldBackgroundColor;
    return Obx(() {
      final isSelected = appPrefs.drawerState() == drawerState;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: isSelected ? 11 : 15),
                child: !isSelected
                    ? SizedBox()
                    : ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        child: Container(
                          width: 4,
                          height: 44,
                          color: Colors.white,
                        ),
                      ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(
                    Radius.circular(isSelected ? 8.0 : 22.0),
                  ),
                ),
                child: IconButton(
                  icon: icon!,
                  onPressed: action,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AutoSizeText(
                title!,
                maxLines: 1,
                minFontSize: 10,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      );
    });
  }
}
