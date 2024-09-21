import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';

class LongestStreakButton extends StatelessWidget {
  final int longestStreak;
  const LongestStreakButton({super.key, required this.longestStreak});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Your Longest Streak',
          style: TextStyle(
            color: AppColors.customBlack.withOpacity(0.5),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$longestStreak days',
              style: TextStyle(
                color: AppColors.customBlack,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5.w),
            const Icon(
              FlutterRemix.fire_fill,
              color: Colors.orangeAccent,
            ),
          ],
        ),
       
      ],
    );
  }
}
