import 'package:cloud_firestore/cloud_firestore.dart';

import '../imports.dart';

AppConfigs get appConfigs => Get.find();

class AppConfigs {
  final String termsURL;
  final String privacyURL;
  final String giphyApiKey;
  final int imageCompressQuality;
  final int maxVideoDuration; //In Minutes
  final int maxSoundDuration; //In Minutes
  AppConfigs({
    required this.termsURL,
    required this.privacyURL,
    required this.giphyApiKey,
    required this.imageCompressQuality,
    required this.maxVideoDuration,
    required this.maxSoundDuration,
  });

  static Future<void> init() async {
    var config = AppConfigs.fromMap({});
    try {
      final doc = await FirebaseFirestore.instance.doc('app/configs').get();
      if (!doc.exists) {
        doc.reference.set(config.toMap());
      } else {
        config = AppConfigs.fromMap(doc.data()!);
      }
    } catch (e) {
      logError('Make sure you deloyed firebase configs');
    }
    Get.put(config);
  }

  Map<String, dynamic> toMap() {
    return {
      'termsURL': termsURL,
      'privacyURL': privacyURL,
      'giphyApiKey': giphyApiKey,
      'imageCompressQuality': imageCompressQuality,
      'maxVideoDuration': maxVideoDuration,
      'maxSoundDuration': maxSoundDuration,
    };
  }

  factory AppConfigs.fromMap(Map<String, dynamic> map) {
    return AppConfigs(
      termsURL: map['termsURL'] as String? ?? '',
      privacyURL: map['privacyURL'] as String? ?? '',
      giphyApiKey: map['giphyApiKey'] as String? ?? '',
      imageCompressQuality:
          int.tryParse('${map['imageCompressQuality'] ?? ''}') ?? 80,
      maxVideoDuration: int.tryParse('${map['maxVideoDuration'] ?? ''}') ?? 5,
      maxSoundDuration: int.tryParse('${map['maxSoundDuration'] ?? ''}') ?? 5,
    );
  }
}
