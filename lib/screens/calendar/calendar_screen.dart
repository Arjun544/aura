import 'package:aura/models/mood_model.dart';
import 'package:aura/providers/calendar_providers/calendar_provider.dart';
import 'package:aura/screens/add_mood/add_mood_screen.dart';
import 'package:aura/widgets/custom_sheet.dart';
import 'package:aura/widgets/custom_text_button.dart';
import 'package:aura/widgets/riverpod_infinite_scroll/src/river_paged_builder.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import '../../providers/common/supabase_provider.dart';
import '../../widgets/top_bar.dart';
import 'components/mood_tile.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const TopBar(),
            Expanded(
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                  child: layout == 'list'
                      ? RiverPagedBuilder<int, MoodModel>(
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
                          firstPageErrorIndicatorBuilder: (_, controller) =>
                              Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Failed to get moods',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        AppColors.customBlack.withOpacity(0.5),
                                  ),
                                ),
                                CustomTextButton(
                                  text: 'Retry',
                                  size: 14.sp,
                                  onPressed: () =>
                                      ref.invalidate(moodsListProvider),
                                  color: AppColors.errorColor,
                                ),
                              ],
                            ),
                          ),
                          newPageErrorIndicatorBuilder: (_, controller) =>
                              Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Failed to get moods',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        AppColors.customBlack.withOpacity(0.5),
                                  ),
                                ),
                                CustomTextButton(
                                  text: 'Retry',
                                  size: 14.sp,
                                  onPressed: () =>
                                      ref.invalidate(moodsListProvider),
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
                                    color:
                                        AppColors.customBlack.withOpacity(0.5),
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
                        )
                      : const FlutterLogo(
                          key: ValueKey('calendar view'),
                        )
                  // : const CalendarView(
                  //     key: ValueKey('calendar view'),
                  //   ),
                  ),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'events_layout',
            elevation: 0,
            backgroundColor: AppColors.customGrey,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              ),
              child: layout == 'calendar'
                  ? Icon(
                      key: const ValueKey('list'),
                      FlutterRemix.menu_5_fill,
                      color: AppColors.customBlack,
                      size: 24.sp,
                    )
                  : Icon(
                      key: const ValueKey('calendar'),
                      IconsaxBold.calendar,
                      color: AppColors.customBlack,
                      size: 24.sp,
                    ),
            ),
            onPressed: () async {
              await ref.watch(supabaseProvider).auth.updateUser(
                    UserAttributes(
                      data: {
                        'events_layout': layout == 'list' ? 'calendar' : 'list',
                      },
                    ),
                  );

              ref.read(layoutProvider.notifier).state =
                  layout == 'list' ? 'calendar' : 'list';
            },
          ),
          SizedBox(height: 10.h),
          FloatingActionButton(
            elevation: 0,
            backgroundColor: AppColors.primary,
            child: const Icon(
              FlutterRemix.user_smile_fill,
              size: 28,
              color: AppColors.customBlack,
            ),
            onPressed: () => showCustomSheet(child: const AddMoodScreen()),
          ),
        ],
      ),
    );
  }
}
