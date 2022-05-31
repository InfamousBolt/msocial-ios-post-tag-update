import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'logger.dart';

class AppAuthException implements Exception {
  final String? message;

  AppAuthException(this.message);
  factory AppAuthException.handleError(e, [StackTrace? s]) {
    String? msg;
    if (e is FirebaseAuthException) {
      msg = e.message;
    } else if (e is PlatformException) {
      if (e.code == 'ERROR_INVALID_VERIFICATION_CODE') {
        msg = 'Oops! vefication code is wrong';
      } else {
        msg = e.message;
      }
    } else {
      msg = e.toString();
    }
    if (msg!.isEmpty) {
      msg = 'Ooops! something went wrong, Please check your network!';
    } else if (msg.contains('password is invalid')) {
      msg = 'Ooops! email or password is not correct!';
    } else if (msg.contains('no user record')) {
      msg = 'Ooops! no user found, if not register consider sign up first!';
    } else if (msg.contains('email address is already')) {
      msg = 'Ooops! this email is already used by another account!';
    } else if (msg.contains('The format of the phone number')) {
      msg = 'Ooops! phone format is invalid';
    }
    logError(msg, e, s);
    return AppAuthException(msg);
  }

  @override
  String toString() => message!;
}

class NotFoundException implements Exception {
  final dynamic message;
  NotFoundException([this.message]) : super();
}
