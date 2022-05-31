import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../components/form_field.dart';
import '../../../../imports.dart';
import '../../data/user.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();

  final photoUploader = AppUploader();
  final coverUploader = AppUploader();
  final isLoading = false.obs;

  User? get user => edited ?? authProvider.user;

  User? edited;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 600,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Obx(
                  () => Stack(
                    children: [
                      AppImage(
                        ImageModel(
                          coverUploader.path(user!.coverPhotoURL),
                          height: 200,
                          width: double.maxFinite,
                        ),
                        errorAsset: Assets.images.cover.path,
                        fit: BoxFit.cover,
                      ),
                      if (coverUploader.isUploading)
                        Center(child: CircularProgressIndicator())
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5.0,
                        color: theme.primaryColorDark,
                        child: Theme(
                          data: ThemeData.dark(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 70),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AppText(
                                      '@${user!.username}',
                                      size: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AppTextFormField(
                                          label: t.FirstName,
                                          initialValue: user!.firstName,
                                          maxLength: 10,
                                          labelSize: 12,
                                          validator: (s) => s!.isEmpty
                                              ? t.AddValidFirstName
                                              : null,
                                          onSave: (v) {
                                            if (v!.trim().isEmpty ||
                                                v == user!.firstName) {
                                              return;
                                            }
                                            edited =
                                                user!.copyWith(firstName: v);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: AppTextFormField(
                                          label: t.LastName,
                                          initialValue: user!.lastName,
                                          maxLength: 10,
                                          validator: (s) => s!.isEmpty
                                              ? t.AddValidLastName
                                              : null,
                                          onSave: (v) {
                                            if (v!.trim().isEmpty ||
                                                v == user!.lastName) {
                                              return;
                                            }
                                            edited =
                                                user!.copyWith(lastName: v);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppTextFormField(
                                    initialValue: user!.status,
                                    label: t.Status,
                                    icon: FontAwesomeIcons.adjust,
                                    maxLength: 30,
                                    onSave: (v) {
                                      if (v!.trim().isEmpty ||
                                          v == user!.status) {
                                        return;
                                      }
                                      edited = user!.copyWith(status: v);
                                    },
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Obx(
                        () => AppButton(
                          t.Save,
                          isLoading: isLoading(),
                          onTap: onSave,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 70,
                left: 0,
                right: 0,
                child: Center(
                  child: Obx(
                    () => AvatarWidget(
                      photoUploader.path(user!.photoURL),
                      isLoading: photoUploader.isUploading,
                      radius: 140,
                      onTap: () =>
                          photoUploader.pick(context, enableCrop: true),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Appbar(
                  backgroundColor: Colors.transparent,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => coverUploader.pick(context),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSave() async {
    formKey.currentState!.save();
    FocusScope.of(context).unfocus();
    isLoading(true);
    try {
      // Update Photo
      if (photoUploader.isPicked) {
        await photoUploader.upload(
          StorageHelper.profilesPicRef,
          onSuccess: (f) => edited = user!.copyWith(photoURL: f.path),
          onFailed: (e) => BotToast.showText(text: e),
        );
      }
      // Update Cover
      if (coverUploader.isPicked) {
        await coverUploader.upload(
          StorageHelper.profilesCoverRef,
          onSuccess: (f) => edited = user!.copyWith(coverPhotoURL: f.path),
          onFailed: (e) => BotToast.showText(text: e),
        );
      }

      if (edited != null) {
        authProvider.rxUser(edited);
        await UserRepository.editProfile(edited!);
      }
      Get.back();
    } catch (e) {
      logError(e);
    }
    isLoading(false);
  }
}
