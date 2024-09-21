import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/get_mood_icon.dart';
import 'package:aura/providers/mood_providers/moods_provider.dart';
import 'package:flutter_svg/svg.dart';

class ThisWeekSection extends HookConsumerWidget {
  const ThisWeekSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final today = DateTime.now();
    final weekDates = _getWeekDates();
    final todayIndex = _getTodayIndex(weekDates, today);

    useEffect(() {
      _scrollToToday(context, scrollController, todayIndex);
      return null;
    }, []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        _buildSectionTitle(),
        SizedBox(height: 10.h),
        _buildWeekList(context, ref, scrollController, weekDates, todayIndex),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text(
        'This Week',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildWeekList(
      BuildContext context,
      WidgetRef ref,
      ScrollController scrollController,
      List<DateTime> weekDates,
      int todayIndex) {
    return SizedBox(
      height: 70.h,
      width: context.width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: weekDates.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemBuilder: (context, index) => _buildDayItem(
            context,
            ref,
            weekDates[index],
            index == todayIndex,
            index == weekDates.length - 1),
      ),
    );
  }

  Widget _buildDayItem(BuildContext context, WidgetRef ref, DateTime date,
      bool isToday, bool isLastItem) {
    final mood = ref.watch(
      dayMoodProvider(formatDate(date, [yyyy, '-', mm, '-', dd])),
    );

    return Container(
      width: 55.h,
      margin: EdgeInsets.only(right: isLastItem ? 0 : 12.w),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isToday ? AppColors.primary : AppColors.customGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDateColumn(date),
          _buildMoodIcon(mood),
        ],
      ),
    );
  }

  Widget _buildDateColumn(DateTime date) {
    return Column(
      children: [
        Text(
          date.day.toString(),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          formatDate(date, [D]),
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.customBlack,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildMoodIcon(AsyncValue<dynamic> mood) {
    return mood.when(
      data: (data) => data.mood != null
          ? SvgPicture.asset(
              getMoodIcon(data.mood!),
              height: 20.h,
              width: 20.w,
            )
          : const SizedBox.shrink(),
      error: (_, __) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }

  List<DateTime> _getWeekDates() {
    final now = DateTime.now();
    // Calculate the start of the week (Monday)
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    // Generate a list of 7 days starting from Monday
    return List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
  }

  int _getTodayIndex(List<DateTime> weekDates, DateTime today) {
    // Find the index of today in the week dates list
    return weekDates.indexWhere(
      (date) =>
          date.day == today.day &&
          date.month == today.month &&
          date.year == today.year,
    );
  }

  void _scrollToToday(
      BuildContext context, ScrollController scrollController, int todayIndex) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (todayIndex != -1) {
        final double scrollPosition =
            (todayIndex * 74.h) - (context.width / 2 - 30.h);
        scrollController.animateTo(
          scrollPosition.clamp(0.0, scrollController.position.maxScrollExtent),
          duration: 300.ms,
          curve: Curves.ease,
        );
      }
    });
  }
}
