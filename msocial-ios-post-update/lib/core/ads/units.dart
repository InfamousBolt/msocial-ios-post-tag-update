import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../imports.dart';

class AdsUnitID extends Equatable {
  static const _TEST_ADS = <String, dynamic>{
    "show": false,
    "test": true,
    "android": {
      "appId": "ca-app-pub-3940256099942544~3347511713",
      "banner": "ca-app-pub-3940256099942544/6300978111",
      "interstitial": "ca-app-pub-3940256099942544/1033173712",
      "rewarded": "ca-app-pub-3940256099942544/5224354917"
    },
    "ios": {
      "appId": "ca-app-pub-3940256099942544~1458002511",
      "banner": "ca-app-pub-3940256099942544/2934735716",
      "interstitial": "ca-app-pub-3940256099942544/4411468910",
      "rewarded": "ca-app-pub-3940256099942544/1712485313"
    },
  };
  final bool test;
  final bool show;
  final String bannedId;
  final String interstitialId;
  final String rewardedId;

  const AdsUnitID({
    required this.test,
    required this.show,
    required this.bannedId,
    required this.interstitialId,
    required this.rewardedId,
  });

  factory AdsUnitID.fromMap(Map map) {
    var ids = (GetPlatform.isAndroid ? map['android'] : map['ios']) as Map;
    final isTest = map['test'] == true;
    if (isTest) {
      ids = GetPlatform.isAndroid
          ? _TEST_ADS['android'] as Map
          : _TEST_ADS['ios'] as Map;
    }
    return AdsUnitID(
      test: isTest,
      show: GetPlatform.isMobile && parseBool(map['show'], true),
      bannedId: parseString(ids['banner']),
      interstitialId: parseString(ids['interstitial']),
      rewardedId: parseString(ids['rewarded']),
    );
  }
  factory AdsUnitID.test() => AdsUnitID.fromMap(_TEST_ADS);

  @override
  List<Object?> get props => [show, bannedId, interstitialId, rewardedId];

  @override
  bool get stringify => true;

  static Future<AdsUnitID> fromFirebase() async {
    AdsUnitID ads = AdsUnitID.test();
    try {
      final doc = FirebaseFirestore.instance.doc('app/ads');
      var data = (await doc.get()).data();
      if (data == null) {
        data = {
          "test": false,
          'show': true,
          ..._TEST_ADS,
        };
        doc.set(data);
      }
      ads = AdsUnitID.fromMap(data);
    } catch (e) {
      logError(e);
    }
    return ads;
  }
}
