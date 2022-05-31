import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../imports.dart';

part 'post_query.freezed.dart';

@freezed
abstract class PostQuery with _$PostQuery {
  static const values = [
    PostQuery.newest(),
    PostQuery.top(),
    PostQuery.hot(),
    PostQuery.myFavorites(),
    PostQuery.myPosts(),
  ];
  const factory PostQuery.hot() = _Hot;
  const factory PostQuery.myFavorites() = _MyFavorites;
  const factory PostQuery.myPosts() = _MyPosts;
  const factory PostQuery.newest() = _New;
  const factory PostQuery.top() = _Top;
}

extension PExt on PostQuery {
  String get text {
    return when<String>(
      newest: () => t.New,
      top: () => t.Top,
      hot: () => t.Hot,
      myFavorites: () => t.Favorites,
      myPosts: () => t.MyPosts,
    );
  }
}
