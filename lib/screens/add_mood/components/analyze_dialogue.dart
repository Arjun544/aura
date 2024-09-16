import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/models/mood_model.dart';
import 'package:aura/providers/mood_providers/add_mood_provider.dart';
import 'package:aura/utils/moods.dart';
import 'package:aura/widgets/custom_button.dart';
import 'package:aura/widgets/custom_text_button.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter_svg/svg.dart';

class AnalyzeDialogue extends ConsumerWidget {
  final MoodModel mood;
  final TextEditingController note;
  const AnalyzeDialogue({
    super.key,
    required this.mood,
    required this.note,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logSuccess(mood.mood.toString());
    final newMood = moods.firstWhere(
      (element) =>
          element.mood.toLowerCase() == mood.mood!.toLowerCase() ,
    );

    final isLoading = ref.watch(addMoodProvider).isLoading;

    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: context.height * 0.15,
          horizontal: 15.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: context.theme.scaffoldBackgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Successfully Analyzed',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Blob.animatedRandom(
              size: context.height * 0.4,
              loop: true,
              duration: 1.seconds,
              styles: BlobStyles(
                color: newMood.color.withOpacity(0.3),
              ),
              child: Center(
                child: SvgPicture.asset(
                  newMood.emoji,
                  height: context.height * 0.15,
                  width: context.height * 0.15,
                ),
              ),
            ).animate().fade(duration: 1000.ms).moveX(duration: 1000.ms),
            Column(
              children: [
                CustomTextButton(
                  text: 'Later',
                  color: context.theme.textTheme.labelSmall!.color!
                      .withOpacity(0.4),
                  size: 14.sp,
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                ),
                SizedBox(height: 5.h),
                CustomButton(
                  height: 45.h,
                  width: context.width * 0.4,
                  text: 'Save',
                  isLoading: isLoading,
                  color: AppColors.primary,
                  onPressed: () async =>
                      ref.read(addMoodProvider.notifier).addMood(
                            context: context,
                            noteController: note,
                            mood: mood,
                          ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
