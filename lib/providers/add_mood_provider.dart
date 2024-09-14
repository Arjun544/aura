import 'dart:async';

import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';

final addMoodProvider =
    AutoDisposeAsyncNotifierProvider<AddMoodNotifier, void>(
  () => AddMoodNotifier(),
);



class AddMoodNotifier extends AutoDisposeAsyncNotifier {
  @override
  FutureOr build() {}

  Future<void> handleAnalyze({
    required BuildContext context,
  }) async {
    state = const AsyncLoading();

    
  }
}
