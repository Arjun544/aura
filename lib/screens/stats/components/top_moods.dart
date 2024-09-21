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
    final top3Moods = useMemoized(() => _getTop3Moods(topMoods), const []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        _buildMoodsContainer(context, top3Moods),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Text(
        'Top Moods',
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMoodsContainer(BuildContext context, List<MoodModel> top3Moods) {
    return Container(
      height: context.height * 0.25,
      width: context.width,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.customGrey,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: top3Moods.asMap().entries.map((entry) {
          final index = entry.key;
          final mood = entry.value;
          return _buildMoodItem(context, mood, index);
        }).toList(),
      ),
    );
  }

  Widget _buildMoodItem(BuildContext context, MoodModel mood, int index) {
    final color = _getMoodColor(mood.mood!);
    final isMiddle = index == 1;

    return Expanded(
      flex: isMiddle ? 2 : 1,
      child: Container(
        height: isMiddle ? context.height * 0.22 : context.height * 0.15,
        margin: EdgeInsets.symmetric(horizontal: isMiddle ? 35.w : 5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: color.withOpacity(0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(getMoodIcon(mood.mood!)),
            Text(
              mood.mood!.capitalizeFirst!,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
            _buildRankBadge(index, color),
          ],
        ),
      ),
    );
  }

  Widget _buildRankBadge(int index, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Text(
        '#${index == 1 ? 1 : index == 0 ? 2 : 3}',
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getMoodColor(String mood) {
    return localMoods
        .firstWhere(
          (element) => element.mood.toLowerCase() == mood.toLowerCase(),
          orElse: () => localMoods.first,
        )
        .color;
  }

  List<MoodModel> _getTop3Moods(List<MoodModel> moods) {
    // Sort moods by score in descending order
    List<MoodModel> sortedList = moods.toList()
      ..sort((a, b) => b.score!.compareTo(a.score!));
    
    // Get top 3 moods
    List<MoodModel> top3 = sortedList.take(3).toList();
    
    // Return in order: 2nd, 1st, 3rd
    return [top3[1], top3[0], top3[2]];
  }
}
