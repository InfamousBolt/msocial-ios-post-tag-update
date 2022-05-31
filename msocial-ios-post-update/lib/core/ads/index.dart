import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../imports.dart';
import 'banner.dart';
import 'units.dart';

class AdsHelper {
  AdsUnitID adsUnitId = AdsUnitID.test();

  int nbrBeforeShowAds = 0;

  InterstitialAd? interstitialAd;
  RewardedAd? rewardAd;

  AdsHelper() {
    init();
  }

  Widget banner() =>
      !adsUnitId.show ? SizedBox() : BannerAdWidget(adsUnitId.bannedId);

  void dispose() {
    rewardAd?.dispose();
    interstitialAd?.dispose();
  }

  Future<void> init() async {
    if (!GetPlatform.isMobile) return;
    MobileAds.instance.initialize();
    adsUnitId = await AdsUnitID.fromFirebase();
    loadFullAds();
  }

  Future<void> loadFullAds() async {
    if (!adsUnitId.show) return;
    await InterstitialAd.load(
      adUnitId: adsUnitId.interstitialId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => interstitialAd = ad,
        onAdFailedToLoad: (e) {
          logInfo('InterstitialAd failed to load: ${e.message}');
        },
      ),
    );
    await RewardedAd.load(
      adUnitId: adsUnitId.rewardedId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => rewardAd = ad,
        onAdFailedToLoad: (e) {
          logInfo('RewardedAd failed to load: ${e.message}');
        },
      ),
    );
  }

  Future<void> showFullAds() async {
    if (!adsUnitId.show) return;
    nbrBeforeShowAds++;
    if (nbrBeforeShowAds < 10) return;
    nbrBeforeShowAds = 0;
    if (rewardAd != null) {
      rewardAd?.show(onUserEarnedReward: (_, __) {});
    } else if (interstitialAd != null) {
      interstitialAd?.show();
    }
    loadFullAds();
  }
}
