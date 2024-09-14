import 'dart:async';
import 'dart:developer';

import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/show_toast.dart';
import 'package:aura/services/auth_service.dart';

final anonymousAuthProvider =
    AutoDisposeAsyncNotifierProvider<AnonymousAuthNotifier, void>(
  () => AnonymousAuthNotifier(),
);

final gmailAuthProvider =
    AutoDisposeAsyncNotifierProvider<GmailAuthNotifier, void>(
  () => GmailAuthNotifier(),
);

class AnonymousAuthNotifier extends AutoDisposeAsyncNotifier {
  @override
  FutureOr build() {}

  Future<void> loginAnonymously({
    required BuildContext context,
  }) async {
    state = const AsyncLoading();

    final response = await ref.read(authServiceProvider).loginAnonymously();

    response.mapBoth(
      onLeft: (l) {
        log(l.error.toString());
        state = AsyncValue.error(l.error.toString(), StackTrace.current);
        showToast(context, message: l.error.toString(), status: 'error');
      },
      onRight: (data) {
        if (context.mounted && data == true) {
          state = const AsyncData(true);
          context.go(Routes.home);
        }
      },
    );
  }
}

class GmailAuthNotifier extends AutoDisposeAsyncNotifier {
  @override
  FutureOr build() {}

  Future<void> loginWithGoogle({
    required BuildContext context,
  }) async {
    state = const AsyncLoading();

    final response = await ref.read(authServiceProvider).loginWithGoogle();

    response.mapBoth(
      onLeft: (l) {
        log(l.error.toString());
        state = AsyncValue.error(l.error.toString(), StackTrace.current);
        showToast(context, message: l.error.toString(), status: 'error');
      },
      onRight: (data) {
        if (context.mounted && data == true) {
          state = const AsyncData(true);
          context.go(Routes.home);
        }
      },
    );
  }
}
