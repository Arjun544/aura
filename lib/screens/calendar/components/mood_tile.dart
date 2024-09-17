import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/get_mood_icon.dart';
import 'package:aura/models/mood_model.dart';
import 'package:aura/utils/moods.dart';
import 'package:aura/widgets/linear_percent_indicator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timeago/timeago.dart' as timeago;

class MoodTile extends StatelessWidget {
  final MoodModel mood;
  const MoodTile({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  getMoodIcon(mood.mood!),
                ),
                Expanded(
                  child: Align(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4.h),
                      width: 2.w,
                      decoration: BoxDecoration(
                        color: AppColors.customGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.customGrey.withOpacity(0.4),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mood.mood!.capitalizeFirst!,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${timeago.format(mood.createdAt!, locale: 'en_short')} ago',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.customBlack.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    if (mood.emotions != null)
                      Column(
                        children: mood.emotions!
                            .where((item) => item.score! > 0.3)
                            .toList()
                            .map((emotion) {
                          final Color color = moods
                              .firstWhere(
                                (element) =>
                                    element.mood.toLowerCase() ==
                                    emotion.label!.toLowerCase(),
                              )
                              .color;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: SizedBox(
                              height: 30.h,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    getMoodIcon(emotion.label!),
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 10.h,
                                      child: LinearPercentIndicator(
                                        lineHeight: 14.0,
                                        percent: emotion.score! / 100,
                                        animation: true,
                                        backgroundColor: AppColors.customGrey,
                                        progressColor: color,
                                        barRadius: const Radius.circular(4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
