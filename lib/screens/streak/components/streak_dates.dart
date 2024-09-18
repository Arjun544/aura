import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';

class StreakDates extends HookWidget {
  final List<DateTime> streakDates;

  const StreakDates({super.key, required this.streakDates});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = useScrollController();
    final today = DateTime.now();

    return SizedBox(
      height: 60.h,
      width: context.width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: streakDates.length + 9,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemBuilder: (BuildContext context, int index) {
          // Determine the last date in existingDates, or default to today if existingDates is empty
          final lastDate = streakDates.isNotEmpty ? streakDates.last : today;

          // Generate a list of next 10 new dates as placeholders
          final newDates = List.generate(
            10,
            (i) => lastDate.add(Duration(days: i)),
          );

          final allDates = <DateTime>{...streakDates, ...newDates}.toList();
          final date = allDates[index];
          final int todayIndex = allDates.indexWhere(
            (date) =>
                date.day == today.day &&
                date.month == today.month &&
                date.year == today.year,
          );

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

          final isToday = index == todayIndex;

          return Container(
            width: 45.h,
            margin:
                EdgeInsets.only(right: index == allDates.length - 1 ? 0 : 14.w),
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: isToday ? AppColors.primary : AppColors.customGrey,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                date.difference(today.add(const Duration(days: 1))).inDays < 0
                    ? Icon(
                        IconsaxBold.tick_circle,
                        size: 20.sp,
                        color: AppColors.successColor.withOpacity(0.5),
                      )
                    : Text(
                        formatDate(date, [D]),
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.customBlack,
                          letterSpacing: 1,
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
