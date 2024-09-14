import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/models/mood_model.dart';
import 'package:aura/utils/moods.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter_svg/svg.dart';

class EmojiView extends StatelessWidget {
  final ValueNotifier<MoodModel?> selectedMood;

  const EmojiView({super.key, required this.selectedMood});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: context.height * 0.5,
          width: context.width,
          child: PageView.builder(
            itemCount: moods.length,
            onPageChanged: (value) => selectedMood.value = moods[value],
            itemBuilder: (context, index) {
              final mood = moods[index];
              return Center(
                child: Column(
                  children: [
                    Text(
                      mood.mood,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ).animate().moveX(duration: 1000.ms),
                    Blob.animatedRandom(
                      size: context.height * 0.4,
                      loop: true,
                      duration: 1.seconds,
                      styles: BlobStyles(
                        color: mood.color.withOpacity(0.3),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          mood.emoji,
                          height: context.height * 0.15,
                          width: context.height * 0.15,
                        ),
                      ),
                    )
                        .animate()
                        .fade(duration: 1000.ms)
                        .moveX(duration: 1000.ms),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
