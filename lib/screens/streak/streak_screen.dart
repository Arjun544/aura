import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/providers/streak_providers.dart';
import 'package:aura/widgets/custom_text_button.dart';
import 'package:aura/widgets/top_bar.dart';

import 'components/longest_streak_button.dart';
import 'components/streak_dates.dart';

class StreakScreen extends ConsumerWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(streakProvider);

    return Scaffold(
      appBar: const TopBar(),
      body: streak.when(
        data: (data) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(streakProvider);
          },
          color: AppColors.primary,
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              SizedBox(height: context.height * 0.05),
              Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 90.h,
                      width: 90.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.customGrey,
                            spreadRadius: 5,
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Icon(
                        FlutterRemix.fire_fill,
                        size: 60.sp,
                        color: AppColors.primary,
                      ),
                    )
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(duration: 2000.ms),
                    Positioned(
                      bottom: -30,
                      child: Text(
                        data.streakCount.toString(),
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.customBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.height * 0.05),
              Center(
                child: Text(
                  data.streakCount == 0
                      ? "Add a mood, start streak!"
                      : "You're doing really great!",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.customBlack.withOpacity(0.5),
                  ),
                ),
              ),
              SizedBox(height: context.height * 0.05),
              StreakDates(
                streakDates: data.streakDates ?? [],
              ),
              SizedBox(height: context.height * 0.15),
              LongestStreakButton(
                longestStreak: data.longestStreak ?? 0,
              ),
            ],
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to get streak',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.customBlack.withOpacity(0.5),
                ),
              ),
              CustomTextButton(
                text: 'Retry',
                size: 14.sp,
                onPressed: () => ref.invalidate(streakProvider),
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
