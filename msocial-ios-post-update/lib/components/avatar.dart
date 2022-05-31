import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../imports.dart';

class AvatarWidget extends StatelessWidget {
  final String photo;
  final double radius;
  final bool showBadge;
  final bool isLoading;
  final VoidCallback? onTap;
  final String? errorAsset;
  final Color? badgeColor;

  const AvatarWidget(
    this.photo, {
    Key? key,
    this.radius = 70,
    this.showBadge = false,
    this.isLoading = false,
    this.onTap,
    this.errorAsset,
    this.badgeColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Badge(
      showBadge: showBadge || onTap != null,
      badgeColor: Colors.green,
      padding: EdgeInsets.all(0),
      badgeContent: CircleAvatar(
        backgroundColor: badgeColor ?? Colors.green,
        radius: showBadge ? 8 : 15,
        child: onTap == null
            ? null
            : GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
      ),
      position: BadgePosition(bottom: 1, end: 1),
      child: ClipOval(
        child: Container(
          width: radius,
          height: radius,
          color: context.theme.primaryColor,
          child: Stack(
            children: [
              Positioned.fill(
                child: AppImage(
                  ImageModel(photo, height: radius, width: radius),
                  errorAsset: errorAsset ?? Assets.images.avatar.path,
                  fit: BoxFit.cover,
                ),
              ),
              if (isLoading) Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      ),
    );
  }
}
