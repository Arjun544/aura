import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/get_mood_icon.dart';
import 'package:aura/utils/moods.dart';
import 'package:aura/widgets/top_bar.dart';
import 'package:flutter_svg/svg.dart';

import 'components/top_moods.dart';

class StatsScreen extends HookWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTime = useState('Weekly');
    final touchedIndex = useState(-1);

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

    List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
          switch (i) {
            case 0:
              return makeGroupData(0, 5, isTouched: i == touchedIndex.value);
            case 1:
              return makeGroupData(1, 6.5, isTouched: i == touchedIndex.value);
            case 2:
              return makeGroupData(2, 5, isTouched: i == touchedIndex.value);
            case 3:
              return makeGroupData(3, 7.5, isTouched: i == touchedIndex.value);
            case 4:
              return makeGroupData(4, 9, isTouched: i == touchedIndex.value);
            case 5:
              return makeGroupData(5, 11.5, isTouched: i == touchedIndex.value);
            case 6:
              return makeGroupData(6, 6.5, isTouched: i == touchedIndex.value);
            default:
              return throw Error();
          }
        });

    Widget getTitles(double value, TitleMeta meta) {
      const style = TextStyle(
        color: AppColors.customBlack,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      );
      Widget text;
      switch (value.toInt()) {
        case 0:
          text = const Text('10', style: style);
          break;
        case 1:
          text = const Text('20', style: style);
          break;
        case 2:
          text = const Text('30', style: style);
          break;
        case 3:
          text = const Text('40', style: style);
          break;
        case 4:
          text = const Text('50', style: style);
          break;
        case 5:
          text = const Text('60', style: style);
          break;
        case 6:
          text = const Text('70', style: style);
          break;
        default:
          text = const Text('', style: style);
          break;
      }
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 16,
        child: text,
      );
    }

    return Scaffold(
      appBar: const TopBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopMoods(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                'Your Statistics',
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
                      getTooltipColor: (_) => Colors.white,
                      tooltipRoundedRadius: 14,
                      tooltipHorizontalAlignment: FLHorizontalAlignment.right,
                      tooltipMargin: -10,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${moods[group.x.toInt()].mood.capitalizeFirst}\n',
                          TextStyle(
                            color: AppColors.customBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: (rod.toY - 1).toString(),
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
                    touchCallback: (FlTouchEvent event, barTouchResponse) {
                      if (!event.isInterestedForInteractions ||
                          barTouchResponse == null ||
                          barTouchResponse.spot == null) {
                        touchedIndex.value = -1;
                        return;
                      }
                      touchedIndex.value =
                          barTouchResponse.spot!.touchedBarGroupIndex;
                      if (!event.isInterestedForInteractions ||
                          barTouchResponse.spot == null) {
                        touchedIndex.value = -1;
                        return;
                      }
                      touchedIndex.value =
                          barTouchResponse.spot!.touchedBarGroupIndex;
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
                        getTitlesWidget: (double value, TitleMeta meta) =>
                            Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SvgPicture.asset(
                            getMoodIcon(moods[value.toInt()].mood),
                          ),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: getTitles,
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
                  barGroups: showingGroups(),
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
