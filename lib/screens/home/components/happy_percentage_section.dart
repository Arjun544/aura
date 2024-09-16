import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/providers/mood_providers/moods_provider.dart';
import 'package:flutter_svg/svg.dart';

class HappyPercentageSection extends ConsumerWidget {
  const HappyPercentageSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final happyPercentage = ref.watch(happyPercentageProvider);

    return Container(
      height: context.height * 0.25,
      margin: EdgeInsets.fromLTRB(15.w, 40.h, 15.w, 0.h),
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
              '${happyPercentage.valueOrNull?.toStringAsFixed(0) ?? '0'}%',
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ).animate().fadeIn(duration: 500.ms),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: LineChart(
              LineChartData(
                lineTouchData: const LineTouchData(enabled: false),
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
                    spots: const [
                      FlSpot(0, 0.2),
                      FlSpot(1, 0.8),
                      FlSpot(2, 0.6),
                      FlSpot(3, 0.9),
                      FlSpot(4, 0.7),
                      FlSpot(5, 0.1),
                    ],
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
                        0.05,
                        0.5,
                        0.9,
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
