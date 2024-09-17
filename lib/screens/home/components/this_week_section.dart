import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/get_mood_icon.dart';
import 'package:aura/providers/mood_providers/moods_provider.dart';
import 'package:flutter_svg/svg.dart';

class ThisWeekSection extends HookConsumerWidget {
  const ThisWeekSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = useScrollController();

    final today = DateTime.now();

    final List<DateTime> getCurrentWeekDates = useMemoized(() {
      DateTime now = DateTime.now();
      int currentWeekday = now.weekday;

      // Calculate the start of the week (Monday)
      DateTime startOfWeek = now.subtract(Duration(days: currentWeekday - 1));

      // Generate the dates for the week starting from Monday
      List<DateTime> weekDates = [];
      for (int i = 0; i < 7; i++) {
        weekDates.add(startOfWeek.add(Duration(days: i)));
      }

      return weekDates;
    }, []);

    final List<DateTime> weekDates = getCurrentWeekDates;

    final int todayIndex = weekDates.indexWhere(
      (date) =>
          date.day == today.day &&
          date.month == today.month &&
          date.year == today.year,
    );

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (todayIndex != -1) {
          // Ensure we scroll to center today in view
          final double scrollPosition =
              (todayIndex * 74.h) - (context.width / 2 - 30.h);
          scrollController.animateTo(
              scrollPosition.clamp(
                  0.0, scrollController.position.maxScrollExtent),
              duration: 300.ms,
              curve: Curves.ease);
        }
      });
      return null;
    }, []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Text(
            'This Week',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 70.h,
          width: context.width,
          child: ListView.builder(
            controller: scrollController,
            itemCount: weekDates.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemBuilder: (BuildContext context, int index) {
              final date = weekDates[index];
              final isToday = index == todayIndex;

              final mood = ref.watch(
                dayMoodProvider(
                  formatDate(date, [yyyy, '-', mm, '-', dd]),
                ),
              );

              return Container(
                width: 55.h,
                margin: EdgeInsets.only(
                    right: index == weekDates.length - 1 ? 0 : 12.w),
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: isToday ? AppColors.primary : AppColors.customGrey,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          formatDate(
                            date,
                            [D],
                          ),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.customBlack,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    mood.when(
                      data: (data) => data.mood != null
                          ? SvgPicture.asset(
                              getMoodIcon(data.mood!),
                              height: 20.h,
                              width: 20.w,
                            )
                          : const SizedBox.shrink(),
                      error: (error, stackTrace) => const SizedBox(),
                      loading: () => const SizedBox(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
