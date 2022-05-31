import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../imports.dart';

Future<void>? toAboutPage() => Get.to(() => AboutPage());

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(t.About),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Image.asset(
              Assets.appIcon.path,
              height: 200,
            ),
          ),
          SizedBox(height: 10),
          Text(
            t.AppName,
            style: GoogleFonts.cairo(textStyle: theme.textTheme.headline5),
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text(t.About),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationIcon: Image.asset(
                  Assets.appIcon.path,
                  height: 80,
                ),
                applicationName: t.AppName,
                applicationVersion: t.AppVersion,
                applicationLegalese: 'ShrApps',
                useRootNavigator: false,
                children: [
                  Text(t.AboutApp, textAlign: TextAlign.justify),
                ],
              );
            },
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text(t.PrivacyPolicy),
            trailing: Icon(Icons.chevron_right),
            onTap: () => launchURL(appConfigs.privacyURL),
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text("Terms & Conditions / EULA"),
            trailing: Icon(Icons.chevron_right),
            onTap: () => launchURL(appConfigs.termsURL),
          ),

        ],
      ),
    );
  }
}
