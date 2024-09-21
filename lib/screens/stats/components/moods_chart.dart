import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/get_mood_icon.dart';
import 'package:aura/models/mood_model.dart';
import 'package:flutter_svg/svg.dart';

class MoodsChart extends HookWidget {
  final List<MoodModel> data;

  const MoodsChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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

    List<BarChartGroupData> showingGroups() => List.generate(
          7,
          (i) => makeGroupData(i, data[i].score ?? 0,
              isTouched: i == touchedIndex.value),
        );

    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => AppColors.customGrey,
            tooltipRoundedRadius: 14,
            tooltipHorizontalAlignment: FLHorizontalAlignment.right,
            tooltipMargin: -10,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
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
          touchCallback: (FlTouchEvent event, barTouchResponse) {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex.value = -1;
              return;
            }
            touchedIndex.value = barTouchResponse.spot!.touchedBarGroupIndex;
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
              getTitlesWidget: (double value, TitleMeta meta) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SvgPicture.asset(
                  getMoodIcon(data[value.toInt()].mood!),
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => SideTitleWidget(
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
        barGroups: showingGroups(),
        gridData: const FlGridData(show: false),
      ),
    );
  }
}
