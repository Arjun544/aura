import 'dart:math' as math;

import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/get_mood_icon.dart';
import 'package:aura/providers/mood_providers/moods_provider.dart';
import 'package:aura/widgets/custom_text_button.dart';
import 'package:flutter_svg/svg.dart';

class RecommendedActivitiesSection extends ConsumerWidget {
  const RecommendedActivitiesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestMood = ref.watch(latestMoodProvider);
    final activities = ref.watch(activitiesProvider);

    return !latestMood.isLoading && latestMood.value?.mood != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommended activities',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'For last mood  ',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        SvgPicture.asset(
                          getMoodIcon(latestMood.value?.mood ?? 'happy'),
                          width: 16.w,
                          height: 16.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              activities.when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.w, horizontal: 15.w),
                        decoration: BoxDecoration(
                          color: AppColors.customGrey,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.only(bottom: 14),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            FlutterRemix.user_smile_fill,
                            size: 24.sp,
                            color: Colors.primaries[
                                math.Random().nextInt(Colors.primaries.length)],
                          ),
                          title: Text(
                            data[index],
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) => Center(
                  heightFactor: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Failed to get activities',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.customBlack.withOpacity(0.5),
                        ),
                      ),
                      CustomTextButton(
                        text: 'Retry',
                        size: 14.sp,
                        onPressed: () => ref.invalidate(activitiesProvider),
                        color: AppColors.errorColor,
                      ),
                    ],
                  ),
                ),
                loading: () => Center(
                  heightFactor: 2,
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.primary,
                    size: 26.sp,
                  ),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
