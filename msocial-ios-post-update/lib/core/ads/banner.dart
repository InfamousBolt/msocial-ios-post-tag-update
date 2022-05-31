import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  final String bannerId;
  const BannerAdWidget(
    this.bannerId, {
    Key? key,
  }) : super(key: key);

  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late BannerAd bannerAd;

  @override
  void initState() {
    bannerAd = BannerAd(
      adUnitId: widget.bannerId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    bannerAd.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: AdWidget(ad: bannerAd),
    );
  }
}
