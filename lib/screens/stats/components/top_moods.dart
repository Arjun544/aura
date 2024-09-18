import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/get_mood_icon.dart';
import 'package:aura/utils/moods.dart';
import 'package:flutter_svg/svg.dart';

class TopMoods extends StatelessWidget {
  const TopMoods({super.key});

  @override
  Widget build(BuildContext context) {
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
            children: moods.take(3).toList().map((e) {
              final index = moods.indexOf(e);
              final mood = e;

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
                    color: mood.color.withOpacity(0.3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        getMoodIcon(mood.mood),
                      ),
                      Text(
                        mood.mood,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: mood.color,
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
