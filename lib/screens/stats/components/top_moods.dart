import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/get_mood_icon.dart';
import 'package:aura/models/mood_model.dart';
import 'package:aura/utils/moods.dart';
import 'package:flutter_svg/svg.dart';

class TopMoods extends HookConsumerWidget {
  final List<MoodModel> topMoods;
  const TopMoods({super.key, required this.topMoods});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignRanks = useMemoized(() {
      List<MoodModel> sortedList = topMoods.toList()
        ..sort((a, b) => b.score!.compareTo(a.score!));

      // Take the top 3 moods
      List<MoodModel> top3Moods = sortedList.take(3).toList();

      // Create a list to store top 3 moods with ranks
      List<MoodModel> rankedTop3Moods = [];

      // Assign ranks to the top 3 moods
      for (int i = 0; i < top3Moods.length; i++) {
        MoodModel moodWithRank = MoodModel(
          mood: top3Moods[i].mood,
          score: top3Moods[i].score,
        );
        rankedTop3Moods.add(moodWithRank);
      }

      return rankedTop3Moods;
    }, const []);

    // Custom arraged moods as per UI
    final top3Moods = [
      assignRanks[1],
      assignRanks[0],
      assignRanks[2],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Text(
            'Top Moods',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: context.height * 0.25,
          width: context.width,
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: AppColors.customGrey,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: top3Moods.map((e) {
              final index = top3Moods.indexOf(e);
              final mood = e;
              final color = localMoods
                  .firstWhere(
                    (element) =>
                        element.mood.toLowerCase() == mood.mood!.toLowerCase(),
                    orElse: () => localMoods.first,
                  )
                  .color;

              return Expanded(
                flex: index == 1 ? 2 : 1,
                child: Container(
                  height: index == 1
                      ? context.height * 0.22
                      : context.height * 0.15,
                  margin: index == 1
                      ? EdgeInsets.symmetric(horizontal: 35.w)
                      : EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: color.withOpacity(0.3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        getMoodIcon(mood.mood!),
                      ),
                      Text(
                        mood.mood!.capitalizeFirst!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                        child: Text(
                          index == 0
                              ? '#2'
                              : index == 1
                                  ? '#1'
                                  : '#3',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
