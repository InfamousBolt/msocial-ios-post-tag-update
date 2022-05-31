import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../imports.dart';

Future<void> showConfirmDialog(
  BuildContext context, {
  String? title,
  String desc = '',
  VoidCallback? onConfirm,
}) async {
  await AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    title: title ?? t.AreYouSure,
    desc: desc,
    btnOk: AppButton('OK', onTap: onConfirm),
  ).show();
}
