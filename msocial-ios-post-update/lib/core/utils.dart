import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'logger.dart';

bool isURL(String s) => RegExp(
      r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$",
    ).hasMatch(s);

Future<void> launchURL(String url) async {
  try {
    await launch(url);
  } catch (e) {
    logError(e);
    BotToast.showText(text: "$e");
  }
}

bool parseBool(dynamic v, [bool d = false]) => v is bool ? v : d;

DateTime parseDate(dynamic ts, [DateTime? d]) {
  final def = d ?? DateTime.now();
  if (ts == null) return def;
  switch (ts.runtimeType) {
    case Timestamp:
      return (ts as Timestamp).toDate();
    case DateTime:
      return ts as DateTime;
    case String:
      return DateTime.parse(ts as String).toLocal();
    case int:
      return DateTime.fromMillisecondsSinceEpoch(ts as int).toLocal();
    default:
      return def;
  }
}

double parseDouble(dynamic v, [double d = 0]) {
  if (v == null) {
    return d;
  } else if (v is double) {
    return v;
  } else if (v is num) {
    return v.toDouble();
  } else {
    return double.tryParse('${v ?? '0'}') ?? d;
  }
}

int parseInt(dynamic v, [int d = 0]) {
  if (v == null) {
    return d;
  } else if (v is int) {
    return v;
  } else if (v is double) {
    return v.toInt();
  } else {
    return int.tryParse('${v ?? '0'}') ?? d;
  }
}

String parseString(dynamic v, [String d = '']) => v is String ? v : '${v ?? d}';
