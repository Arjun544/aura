import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/providers/mood_providers/moods_provider.dart';
import 'package:flutter_svg/svg.dart';

class HappyPercentageSection extends ConsumerWidget {
  const HappyPercentageSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final happyPercentages = ref.watch(happyPercentageProvider);

    return Container(
      height: context.height * 0.25,
      margin: EdgeInsets.fromLTRB(15.w, 40.h, 15.w, 40.h),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: SvgPicture.asset(
                AssetsManager.happyMood,
                height: 20.h,
              ),
            ),
            title: Text(
              'Your Happiness',
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
            trailing: Text(
              happyPercentages.valueOrNull == null
                  ? '0%'
                  : '${happyPercentages.valueOrNull?.first.score?.toStringAsFixed(0) ?? 0}%',
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ).animate().fadeIn(duration: 500.ms),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: LineChart(
              LineChartData(
                minX: 0,
                minY: 0,
                titlesData: const FlTitlesData(
                  show: false,
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                gridData: const FlGridData(
                  show: false,
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: happyPercentages.valueOrNull == null
                        ? [
                            const FlSpot(0, 0.2),
                            const FlSpot(1, 0.8),
                            const FlSpot(2, 0.6),
                            const FlSpot(3, 0.9),
                            const FlSpot(4, 0.7),
                            const FlSpot(5, 0.1),
                          ]
                        : happyPercentages.valueOrNull!.reversed
                            .toList()
                            .map(
                              (e) => FlSpot(
                                happyPercentages.valueOrNull!.reversed
                                    .toList()
                                    .indexOf(e)
                                    .toDouble(),
                                e.score ?? 0.0,
                              ),
                            )
                            .toList(),
                    isCurved: true,
                    color: AppColors.successColor,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    gradient: const LinearGradient(
                      colors: [
                        Colors.white,
                        AppColors.successColor,
                        Colors.white
                      ],
                      stops: [
                        0.01,
                        0.5,
                        1,
                      ],
                    ),
                    dotData: const FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
