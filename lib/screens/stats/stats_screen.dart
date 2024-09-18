import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/get_mood_icon.dart';
import 'package:aura/models/mood_model.dart';
import 'package:aura/providers/stats_provider.dart';
import 'package:aura/screens/add_mood/add_mood_screen.dart';
import 'package:aura/widgets/custom_button.dart';
import 'package:aura/widgets/custom_sheet.dart';
import 'package:aura/widgets/custom_text_button.dart';
import 'package:aura/widgets/top_bar.dart';
import 'package:flutter_svg/svg.dart';

import 'components/top_moods.dart';

class StatsScreen extends HookConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final touchedIndex = useState(-1);

    final stats = ref.watch(statsProvider);

    BarChartGroupData makeGroupData(
      int x,
      double y, {
      bool isTouched = false,
      Color? barColor,
      double width = 22,
      List<int> showTooltips = const [],
    }) {
      barColor ??= AppColors.primary;
      return BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            toY: isTouched ? y + 1 : y,
            color: isTouched ? AppColors.successColor : barColor,
            width: width,
            borderSide: isTouched
                ? const BorderSide(color: AppColors.successColor)
                : const BorderSide(color: Colors.white, width: 0),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: AppColors.customGrey,
            ),
          ),
        ],
        showingTooltipIndicators: showTooltips,
      );
    }

    List<BarChartGroupData> showingGroups(List<MoodModel> data) =>
        List.generate(
          7,
          (i) => makeGroupData(i, data[i].score ?? 0,
              isTouched: i == touchedIndex.value),
        );

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
                              child: BarChart(
                                BarChartData(
                                  barTouchData: BarTouchData(
                                    enabled: true,
                                    touchTooltipData: BarTouchTooltipData(
                                      getTooltipColor: (_) =>
                                          AppColors.customGrey,
                                      tooltipRoundedRadius: 14,
                                      tooltipHorizontalAlignment:
                                          FLHorizontalAlignment.right,
                                      tooltipMargin: -10,
                                      getTooltipItem:
                                          (group, groupIndex, rod, rodIndex) {
                                        return BarTooltipItem(
                                          '${data[group.x.toInt()].mood!.capitalizeFirst}\n',
                                          TextStyle(
                                            color: AppColors.customBlack,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  "${(rod.toY - 1).roundToDouble().toStringAsFixed(0)}%",
                                              style: TextStyle(
                                                color: AppColors.customBlack,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    touchCallback:
                                        (FlTouchEvent event, barTouchResponse) {
                                      if (!event.isInterestedForInteractions ||
                                          barTouchResponse == null ||
                                          barTouchResponse.spot == null) {
                                        touchedIndex.value = -1;
                                        return;
                                      }
                                      touchedIndex.value = barTouchResponse
                                          .spot!.touchedBarGroupIndex;
                                      if (!event.isInterestedForInteractions ||
                                          barTouchResponse.spot == null) {
                                        touchedIndex.value = -1;
                                        return;
                                      }
                                      touchedIndex.value = barTouchResponse
                                          .spot!.touchedBarGroupIndex;
                                    },
                                  ),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 38,
                                        getTitlesWidget:
                                            (double value, TitleMeta meta) =>
                                                Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: SvgPicture.asset(
                                            getMoodIcon(
                                                data[value.toInt()].mood!),
                                          ),
                                        ),
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) =>
                                            SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          space: 16,
                                          child: Text(
                                            data[value.toInt()]
                                                .score!
                                                .roundToDouble()
                                                .toStringAsFixed(0)
                                                .toString(),
                                            style: TextStyle(
                                              color: AppColors.customBlack,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        reservedSize: 38,
                                      ),
                                    ),
                                    leftTitles: const AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: false,
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  barGroups: showingGroups(
                                    data,
                                  ),
                                  gridData: const FlGridData(show: false),
                                ),
                              ),
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
