import 'dart:async';

import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/screens/add_mood/components/analyze_dialogue.dart';
import 'package:aura/utils/moods.dart';
import 'package:aura/widgets/custom_dialogue.dart';

final addMoodProvider = AutoDisposeAsyncNotifierProvider<AddMoodNotifier, void>(
  () => AddMoodNotifier(),
);

class AddMoodNotifier extends AutoDisposeAsyncNotifier {
  @override
  FutureOr build() {}

  Future<void> handleAnalyze({
    required BuildContext context,
  }) async {
    state = const AsyncLoading();
    showCustomDialogue(
      child: AnalyzeDialogue(
        mood: moods.first,
      ),
    );

    state = const AsyncData(null);
  }
}
