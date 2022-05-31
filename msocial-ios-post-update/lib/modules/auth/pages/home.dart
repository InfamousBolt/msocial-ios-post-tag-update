import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../imports.dart';
import '../../feeds/pages/posts/feed.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => authProvider.isLoggedIn() ? FeedPage() : _WelcomePage(),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Image.asset(
                Assets.images.logo.path,
                height: 200,
              ),
              // Text(
              //   t.AppName,
              //   textAlign: TextAlign.center,
              //   style: GoogleFonts.poppins(
              //     fontSize: 38,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Text(
                t.AboutApp,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: context.isDarkMode
                      ? Colors.white
                      : context.theme.primaryColor,
                ),
              ),
              Spacer(),
              AppButton(
                t.START,
                onTap: AuthRoutes.toPhoneLogin,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
