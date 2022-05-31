import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../components/form_field.dart';
import '../../../../imports.dart';
import '../../data/register.dart';
import 'widgets/gender.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Form Fields
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final bioController = TextEditingController();
  final emailController = TextEditingController();

  String gender = t.Male;

  final usernameErrorText = Rxn<String>();
  final accepted = false.obs;
  final isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: Appbar(titleStr: t.Register),
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.height,
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Spacer(),
                Obx(
                  () => AppTextFormField(
                    label: t.Username,
                    icon: Icons.alternate_email,
                    controller: usernameController,
                    formatters: [
                      TextInputFormatter.withFunction((o, n) {
                        final match = n.text.isEmpty ||
                            RegExp(r"^[a-zA-Z0-9_\-]+$").hasMatch(n.text);
                        return !match
                            ? o
                            : n.copyWith(text: n.text.toLowerCase());
                      })
                    ],
                    maxLength: 10,
                    validator: (s) => s!.length < 3 ? t.AddValidUsername : null,
                    errorText: usernameErrorText(),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        label: t.FirstName,
                        controller: firstNameController,
                        maxLength: 10,
                        labelSize: 12,
                        validator: (s) =>
                            s!.isEmpty ? t.AddValidFirstName : null,
                      ),
                    ),
                    Expanded(
                      child: AppTextFormField(
                        label: t.LastName,
                        controller: lastNameController,
                        maxLength: 10,
                        validator: (s) =>
                            s!.isEmpty ? t.AddValidLastName : null,
                      ),
                    ),
                  ],
                ),
                AppTextFormField(
                  label: '${t.Email} (Optional)',
                  icon: Icons.email,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (s) => s?.isNotEmpty == true && !s!.isEmail
                      ? t.InvalidEmail
                      : null,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment(-0.8, 0),
                  child: Text(t.SelectGender),
                ),
                GenderWidget(onSelect: (v) => gender = v!),
                SizedBox(height: 8),
                SizedBox(
                  width: Get.width,
                  child: ListTile(
                    leading: Obx(
                      () => Checkbox(
                        activeColor: theme.colorScheme.secondary,
                        value: accepted(),
                        onChanged: (v) => accepted(v),
                      ),
                    ),
                    title: Text(
                      t.AcceptTerms,
                      style: theme.textTheme.headline6!.copyWith(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () => launchURL(appConfigs.termsURL),
                  ),
                ),
                SizedBox(height: 10),
                Obx(
                  () => AppButton(
                    t.Save,
                    isLoading: isLoading(),
                    onTap: accepted() ? onSave : null,
                  ),
                ),
                Spacer(flex: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSave() async {
    if (!formKey.currentState!.validate()) return;
    isLoading(true);
    try {
      final username = usernameController.text;
      usernameErrorText(null);
      if (await RegisterRepository.checkIfUsernameTaken(username)) {
        usernameErrorText(t.UsernameTaken);
        throw Exception(t.UsernameTaken);
      }

      await RegisterRepository.createNewUser(
        username: username,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        gender: gender,
      );
      await authProvider.login();
    } catch (e) {
      BotToast.showText(text: AppAuthException.handleError(e).message!);
    }
    isLoading(false);
  }
}
