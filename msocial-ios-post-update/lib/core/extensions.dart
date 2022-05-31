import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

extension PagingStateX<PageKeyType, ItemType>
    on PagingState<PageKeyType, ItemType> {
  PagingState<PageKeyType, ItemType> copyWith({
    List<ItemType>? itemList,
    dynamic error,
    PageKeyType? nextPageKey,
  }) =>
      PagingState<PageKeyType, ItemType>(
        itemList: itemList ?? this.itemList,
        error: error ?? this.error,
        nextPageKey: nextPageKey ?? this.nextPageKey,
      );
}
