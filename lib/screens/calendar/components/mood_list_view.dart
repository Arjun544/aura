import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/models/mood_model.dart';
import 'package:aura/providers/calendar_providers/calendar_provider.dart';
import 'package:aura/widgets/custom_text_button.dart';
import 'package:aura/widgets/riverpod_infinite_scroll/src/river_paged_builder.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'mood_tile.dart';

class MoodsListView extends ConsumerWidget {
  const MoodsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RiverPagedBuilder<int, MoodModel>(
      firstPageKey: 0,
      limit: 15,
      provider: moodsListProvider,
      onRefresh: () async {
        // ignore: unused_result
        ref.refresh(moodsListProvider);
      },
      firstPageProgressIndicatorBuilder: (_, __) => Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: AppColors.primary,
          size: 30.sp,
        ),
      ),
      newPageProgressIndicatorBuilder: (_, __) => Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: AppColors.primary,
          size: 30.sp,
        ),
      ),
      firstPageErrorIndicatorBuilder: (_, controller) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Failed to get moods',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.customBlack.withOpacity(0.5),
              ),
            ),
            CustomTextButton(
              text: 'Retry',
              size: 14.sp,
              onPressed: () => ref.invalidate(moodsListProvider),
              color: AppColors.errorColor,
            ),
          ],
        ),
      ),
      newPageErrorIndicatorBuilder: (_, controller) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Failed to get moods',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.customBlack.withOpacity(0.5),
              ),
            ),
            CustomTextButton(
              text: 'Retry',
              size: 14.sp,
              onPressed: () => ref.invalidate(moodsListProvider),
              color: AppColors.errorColor,
            ),
          ],
        ),
      ),
      noItemsFoundIndicatorBuilder: (_, __) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No moods found',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.customBlack.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context, item, index) => MoodTile(
        mood: item,
      ),
      pagedBuilder: (controller, builder) => PagedListView(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 30.h,
        ),
        pagingController: controller,
        builderDelegate: builder,
      ),
    );
  }
}
