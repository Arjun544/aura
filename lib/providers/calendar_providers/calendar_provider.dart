import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/get_pagination.dart';
import 'package:aura/models/mood_model.dart';
import 'package:aura/providers/user_providers/user_provider.dart';
import 'package:aura/services/mood_service.dart';
import 'package:aura/widgets/riverpod_infinite_scroll/src/paged_notifier.dart';
import 'package:aura/widgets/riverpod_infinite_scroll/src/paged_state.dart';

final layoutProvider = StateProvider<String>((ref) {
  ref.watch(userProvider.select((e) => e?.id));
  return ref.watch(userProvider)!.userMetadata?['events_layout'] ?? 'calendar';
});

final moodsListProvider =
    StateNotifierProvider<MoodsListNotifier, PagedState<int, MoodModel>>(
  (ref) {
    ref.watch(userProvider.select((e) => e?.id));
    return MoodsListNotifier(ref);
  },
);

class MoodsListNotifier extends PagedNotifier<int, MoodModel> {
  final StateNotifierProviderRef ref;
  MoodsListNotifier(
    this.ref,
  ) : super(
          load: (page, limit, search) => ref.read(moodServiceProvider).getMoods(
                range: getPagination(page: page, limit: limit),
              ),
          nextPageKeyBuilder: NextPageKeyBuilderDefault.mysqlPagination,
        );

  void update(MoodModel mood) {
    state = state.copyWith(
        records: [...state.records!.map((e) => e.id == mood.id ? mood : e)]);
  }
}
