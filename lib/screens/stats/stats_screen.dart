import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/providers/stats_provider.dart';
import 'package:aura/screens/add_mood/add_mood_screen.dart';
import 'package:aura/widgets/custom_button.dart';
import 'package:aura/widgets/custom_sheet.dart';
import 'package:aura/widgets/custom_text_button.dart';
import 'package:aura/widgets/top_bar.dart';

import 'components/moods_chart.dart';
import 'components/top_moods.dart';

class StatsScreen extends HookConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statsProvider);

    return Scaffold(
      appBar: const TopBar(),
      body: stats.when(
        data: (data) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: RefreshIndicator(
            onRefresh: () async => ref.invalidate(statsProvider),
            color: AppColors.primary,
            backgroundColor: Colors.white,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: data.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'No statistics yet',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.customBlack.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              CustomButton(
                                width: context.width * 0.5,
                                height: 45.h,
                                text: 'Add a mood',
                                onPressed: () => showCustomSheet(
                                  child: const AddMoodScreen(),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TopMoods(
                              topMoods: data,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Text(
                                'Your Moods in %',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: MoodsChart(data: data),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to get stats',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.customBlack.withOpacity(0.5),
                ),
              ),
              CustomTextButton(
                text: 'Retry',
                size: 14.sp,
                onPressed: () => ref.invalidate(statsProvider),
                color: AppColors.errorColor,
              ),
            ],
          ),
        ),
        loading: () => Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: AppColors.primary,
            size: 30.sp,
          ),
        ),
      ),
    );
  }
}
