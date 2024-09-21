import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';

class StreakDates extends HookWidget {
  final List<DateTime> streakDates;

  const StreakDates({super.key, required this.streakDates});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final today = DateTime.now();
    final allDates = _generateAllDates(today);
    final todayIndex = _findTodayIndex(allDates, today);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => _scrollToToday(context, scrollController, todayIndex));
      return null;
    }, []);

    return SizedBox(
      height: 60.h,
      width: context.width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: allDates.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemBuilder: (context, index) => _buildDateItem(context,
            allDates[index], index == todayIndex, index == allDates.length - 1),
      ),
    );
  }

  List<DateTime> _generateAllDates(DateTime today) {
    // Get the last date from streak or use today if streak is empty
    final lastDate = streakDates.isNotEmpty ? streakDates.last : today;
    
    // Generate 10 new dates starting from the last date
    final newDates = List.generate(10, (i) => lastDate.add(Duration(days: i)));
    
    // Combine streak dates and new dates, remove duplicates, and sort
    return <DateTime>{...streakDates, ...newDates}.toList()..sort();
  }

  int _findTodayIndex(List<DateTime> allDates, DateTime today) {
    return allDates.indexWhere((date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day);
  }

  /// Scrolls the ListView to center today's date item
  void _scrollToToday(
      BuildContext context, ScrollController scrollController, int todayIndex) {
    if (todayIndex != -1) {
      // Calculate scroll position to center today's date
      final scrollPosition = (todayIndex * 74.h) - (context.width / 2 - 30.h);
      scrollController.animateTo(
        scrollPosition.clamp(0.0, scrollController.position.maxScrollExtent),
        duration: 300.ms,
        curve: Curves.ease,
      );
    }
  }

  Widget _buildDateItem(
      BuildContext context, DateTime date, bool isToday, bool isLastItem) {
    final today = DateTime.now();
    return Container(
      width: 45.h,
      margin: EdgeInsets.only(right: isLastItem ? 0 : 14.w),
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
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          _buildDateIndicator(date, today),
        ],
      ),
    );
  }

  Widget _buildDateIndicator(DateTime date, DateTime today) {
    if (streakDates.contains(date) &&
        date.isBefore(today.add(const Duration(days: 1)))) {
      return Icon(
        IconsaxBold.tick_circle,
        size: 20.sp,
        color: AppColors.successColor.withOpacity(0.5),
      );
    } else {
      return Text(
        formatDate(date, [D]),
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.customBlack,
          letterSpacing: 1,
        ),
      );
    }
  }
}
