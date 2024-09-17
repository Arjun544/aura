import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/providers/calendar_providers.dart';

class CalendarTimeline extends HookConsumerWidget {
  final ValueNotifier<DateTime> selectedDate;

  const CalendarTimeline({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime now = DateTime.now();

    final List<DateTime> dates = useMemoized(() {
      DateTime now = DateTime.now(); // Get current date and time
      List<DateTime> dateList = [];

      for (int i = 1; i <= now.day; i++) {
        // Iterate up to and include today
        dateList.add(DateTime(now.year, now.month, i));
      }

      return dateList.reversed.toList();
    }, []);

    final int todayIndex = dates.indexWhere(
      (date) =>
          date.day == now.day &&
          date.month == now.month &&
          date.year == now.year,
    );

    void onTap(DateTime newDate) async {
      selectedDate.value = newDate;

      final formattedDate = formatDate(newDate, [yyyy, '-', mm, '-', dd]);
      // Reload the moods as the selected date has changed
      ref.invalidate(moodsDateProvider(formattedDate));
      await ref.read(moodsDateProvider(formattedDate).notifier).load(0, 15, '');
      ref.invalidate(moodsDateProvider(formattedDate));
    }

    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text(
                  formatDate(
                    now,
                    [MM],
                  ),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          SizedBox(
            height: 60.h,
            width: context.width,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: dates.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final date = dates[index];
                final isToday = index == todayIndex;

                return GestureDetector(
                  onTap: () => onTap(date),
                  child: AnimatedContainer(
                    width: 50.h,
                    duration: 500.ms,
                    margin: EdgeInsets.only(
                      right: index == dates.length - 1 ? 0 : 12.w,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isToday && selectedDate.value != date
                          ? AppColors.primary.withOpacity(
                              0.5,
                            )
                          : selectedDate.value == date
                              ? AppColors.primary
                              : AppColors.customGrey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          formatDate(
                            date,
                            [D],
                          ),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.customBlack.withOpacity(0.5),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
