import 'package:algolia/algolia.dart';

class AlgoliaApplication{
  static final Algolia algolia = Algolia.init(
    applicationId: 'QP0PSR8KXY', //ApplicationID
    apiKey: '79246757bc8641db6433e04f396b8acf', //search-only api key in flutter code
  );
}