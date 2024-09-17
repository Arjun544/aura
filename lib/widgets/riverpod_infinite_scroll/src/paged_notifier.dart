import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'paged_notifier_mixin.dart';
import 'paged_state.dart';

typedef LoadFunction<PageKeyType, ItemType> = Future<List<ItemType>?> Function(
    PageKeyType page, int limit, String search);
typedef NextPageKeyBuilder<PageKeyType, ItemType> = PageKeyType? Function(
    List<ItemType>? lastItems, PageKeyType page, int limit, String search);

/// A [StateNotifier] that has already all the properties that `riverpod_infinite_scroll` needs and is intended for simple states only containing a list of `records`
class PagedNotifier<PageKeyType, ItemType>
    extends StateNotifier<PagedState<PageKeyType, ItemType>>
    with
        PagedNotifierMixin<PageKeyType, ItemType,
            PagedState<PageKeyType, ItemType>> {
  /// Load function
  final LoadFunction<PageKeyType, ItemType> _load;

  /// Instructs the class on how to build the next page based on the last answer
  final NextPageKeyBuilder<PageKeyType, ItemType> nextPageKeyBuilder;

  /// A builder for providing a custom error string
  final dynamic Function(dynamic error)? errorBuilder;

  /// A builder for providing a custom error string
  final bool printStackTrace;

  PagedNotifier(
      {required LoadFunction<PageKeyType, ItemType> load,
      required this.nextPageKeyBuilder,
      this.errorBuilder,
      this.printStackTrace = false})
      : _load = load,
        super(PagedState<PageKeyType, ItemType>());

  @override
  Future<List<ItemType>?> load(
      PageKeyType page, int limit, String search) async {
    // avoid repeated call to the same page
    if (state.previousPageKeys.contains(page)) {
      await Future.delayed(const Duration(seconds: 0), () {
        state = state.copyWith();
      });
      return state.records;
    }
    try {
      final records = await _load(page, limit, search);

      state = state.copyWith(
          search: search,
          records: <ItemType>{
            ...(state.records ?? <ItemType>[]),
            ...(records ?? <ItemType>[])
          }.toList(),
          nextPageKey: nextPageKeyBuilder(records, page, limit, search),
          previousPageKeys: {...state.previousPageKeys, page}.toList());
      return records!.toSet().toList();
    } catch (e, stacktrace) {
      if (mounted) {
        state = state.copyWith(
            error: errorBuilder != null
                ? errorBuilder!(e)
                : 'An error occurred. Please try again.');
        debugPrint(e.toString());
        if (printStackTrace) {
          debugPrint(stacktrace.toString());
        }
      }
    }
    return null;
  }
}

class NextPageKeyBuilderDefault<ItemType> {
  static NextPageKeyBuilder<int, dynamic> mysqlPagination =
      (List<dynamic>? lastItems, int page, int limit, String search) {
    return (lastItems == null || lastItems.length < limit) ? null : (page + 1);
  };
}
