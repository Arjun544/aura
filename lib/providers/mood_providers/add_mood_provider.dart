import 'dart:async';
import 'dart:convert';

import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/show_toast.dart';
import 'package:aura/models/local_mood_model.dart';
import 'package:aura/models/mood_model.dart';
import 'package:aura/providers/calendar_providers.dart';
import 'package:aura/providers/stats_provider.dart';
import 'package:aura/providers/streak_providers.dart';
import 'package:aura/screens/add_mood/components/analyse_dialogue.dart';
import 'package:aura/services/mood_service.dart';
import 'package:aura/widgets/custom_dialogue.dart';
import 'package:image_picker/image_picker.dart';

import 'moods_provider.dart';

final addMoodProvider = AutoDisposeAsyncNotifierProvider<AddMoodNotifier, void>(
  () => AddMoodNotifier(),
);

class AddMoodNotifier extends AutoDisposeAsyncNotifier {
  @override
  FutureOr build() {}

  Future<void> handleAnalyse({
    required BuildContext context,
    required String type,
    required TextEditingController textController,
    required TextEditingController noteController,
    required ValueNotifier<XFile?> image,
    required ValueNotifier<LocalMoodModel> emoji,
  }) async {
    state = const AsyncLoading();
    if (type == 'image' && image.value == null && context.mounted) {
      state = const AsyncData(null);
      showToast(context, message: 'Please select an image', status: 'error');
      return;
    }

    if (type == 'text' && textController.text.isNotEmpty) {
      final response = await ref.read(moodServiceProvider).detectMoodFromText(
            text: textController.text.trim(),
          );

      response.mapBoth(
        onLeft: (l) {
          logError(l.error.toString());
          state = AsyncValue.error(l.error.toString(), StackTrace.current);
          showToast(context, message: l.error.toString(), status: 'error');
        },
        onRight: (data) {
          if (data.mood != null) {
            if (context.mounted) {
              state = const AsyncData(null);
              Navigator.of(context, rootNavigator: true).pop();
              showCustomDialogue(
                child: AnalyseDialogue(
                  mood: data,
                  note: noteController,
                ),
              );
              return;
            }
          }
        },
      );
    }

    if (type == 'image' && image.value != null) {
      // Convert image to base64
      final bytes = await image.value!.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await ref.read(moodServiceProvider).detectMoodFromImage(
            image: base64Image,
          );

      response.mapBoth(
        onLeft: (l) {
          logError(l.error.toString());
          state = AsyncValue.error(l.error.toString(), StackTrace.current);
          showToast(context, message: l.error.toString(), status: 'error');
        },
        onRight: (data) {
          if (data.mood != null) {
            if (context.mounted) {
              state = const AsyncData(null);
              Navigator.of(context, rootNavigator: true).pop();
              showCustomDialogue(
                child: AnalyseDialogue(
                  mood: data,
                  note: noteController,
                ),
              );
              return;
            }
          }
        },
      );
    }

    if (type == 'emoji') {
      if (context.mounted) {
        state = const AsyncData(null);
        Navigator.of(context, rootNavigator: true).pop();
        showCustomDialogue(
          child: AnalyseDialogue(
            mood: MoodModel(
              mood: emoji.value.mood.toLowerCase(),
              score: 100,
              emotions: [],
            ),
            note: noteController,
          ),
        );
        return;
      }
    }
  }

  Future<void> addMood({
    required BuildContext context,
    required TextEditingController noteController,
    required MoodModel mood
  }) async {
    state = const AsyncLoading();

    final response = await ref.read(moodServiceProvider).addMood(
          mood: mood,
          note: noteController.text.trim(),
        );

    response.mapBoth(
      onLeft: (l) {
        logError(l.error.toString());
        state = AsyncValue.error(l.error.toString(), StackTrace.current);
        showToast(context, message: l.error.toString(), status: 'error');
      },
      onRight: (_) {
        if (context.mounted) {
          state = const AsyncData(null);
          // showToast(
          //   context,
          //   message: 'Mood added successfully',
          //   status: 'success',
          // );
          ref.invalidate(
            dayMoodProvider(
              formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]),
            ),
          );
          ref.invalidate(happyPercentageProvider);
          ref.invalidate(streakCountProvider);
          ref.invalidate(latestMoodProvider);
          if (ref.exists(streakProvider)) {
            ref.invalidate(streakProvider);
          }
          if (ref.exists(moodsListProvider)) {
            ref.invalidate(moodsListProvider);
          }
          if (ref.exists(statsProvider)) {
            ref.invalidate(statsProvider);
          }
          if (ref.exists(moodsDateProvider(
            formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]),
          ))) {
            ref.invalidate(moodsDateProvider(
              formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]),
            ));
          }

          Navigator.of(context, rootNavigator: true).pop();
        }
      },
    );
  }
}
