import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../imports.dart';
import '../../../data/user.dart';
import 'appbar.dart';

class ProfileHeader extends StatelessWidget implements PreferredSizeWidget {
  final Rxn<User> rxUser;

  const ProfileHeader(
    this.rxUser, {
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(300);

  User get user => rxUser()!;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: user.isMe ? 450 : 500,
      color: theme.scaffoldBackgroundColor,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: user.isMe ? 200 : 250,
            left: 0,
            right: 0,
            child: AppImage(
              ImageModel(user.coverPhotoURL, height: 250),
              fit: BoxFit.fill,
              errorAsset: Assets.images.cover.path,
            ),
          ),
          Positioned(
            bottom: user.isMe ? 50 : 110,
            left: .6,
            right: .6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '@${user.username}',
                        style: GoogleFonts.basic().copyWith(fontSize: 22),
                        maxLines: 1,
                      ),
                      SizedBox(width: 5,),
                      if(user.isVerified)
                        Image.asset('assets/images/verified.png', height: 18, width: 18)
                    ],
                  ),
                  Text(
                    user.fullName,
                    style: GoogleFonts.abel().copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  AppText(
                    user.status,
                    textAlign: TextAlign.center,
                    color: Colors.black,
                    maxLines: 2,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: user.isMe ? 350 : 410,
            child: ProfileAppBar(rxUser),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: user.isMe ? 180 : 230,
            child: Center(
              child: Material(
                elevation: 5,
                shape: CircleBorder(),
                child: AvatarWidget(
                  user.photoURL,
                  radius: 110,
                ),
              ),
            ),
          ),
          //Follow And Message Buttons
          if (!user.isMe)
            Positioned(
              right: 0,
              left: 0,
              bottom: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    user.isFollowing ? t.Following : t.Follow,
                    width: 180,
                    borderRadius: 5,
                    color: Colors.white,
                    backgroundColor: user.isFollowing
                        ? theme.primaryColorLight
                        : theme.primaryColorDark,
                    onTap: () {
                      user.toggleFollowing();
                      rxUser.refresh();
                      UserRepository.followUser(user);
                    },
                  ),
                  AppButton(
                    t.Message,
                    width: 180,
                    borderRadius: 5,
                    onTap: () => ChatRoutes.toPrivateChat(user.id),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
