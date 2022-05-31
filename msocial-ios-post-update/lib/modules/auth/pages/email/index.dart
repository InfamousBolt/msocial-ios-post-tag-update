import 'package:flutter/material.dart';

import '../../../../components/form_field.dart';
import '../../../../imports.dart';
import '../../data/register.dart';
import '../widgets/auth_header.dart';

class EmailLoginPage extends StatefulWidget {
  @override
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  final formKey = GlobalKey<FormState>();

  late String email;
  late String password;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AuthTopHeader(),
              SizedBox(height: 20),
              AppTextFormField(
                label: t.Email,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (s) =>
                    GetUtils.isEmail(s ?? '') ? null : t.InvalidEmail,
                onSave: (v) => email = v ?? '',
              ),
              AppTextFormField(
                label: t.Password,
                icon: Icons.lock,
                onSave: (v) => password = v ?? '',
                isObscure: true,
              ),
              SizedBox(height: 20),
              AppButton(
                t.Save,
                isLoading: isLoading,
                onTap: onSave,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSave() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    setState(() => isLoading = true);
    try {
      await RegisterRepository.login(email, password);
      await authProvider.login();
    } catch (e) {
      BotToast.showText(text: AppAuthException.handleError(e).message!);
    }
    setState(() => isLoading = false);
  }
}
