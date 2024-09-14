import 'dart:ui';

import 'package:aura/utils/routing_keys.dart';

import '../core/imports/core_imports.dart';

Future<void> Function({
  required Widget child,
  bool hasBlur,
}) showCustomDialogue = ({
  required Widget child,
  bool hasBlur = true,
}) {
  return showGeneralDialog(
    context: rootNavigatorKey.currentContext!,
    barrierColor: Colors.black12,
    pageBuilder: (_, __, secondaryAnimation) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: hasBlur ? 2 : 0,
          sigmaY: hasBlur ? 2 : 0,
        ),
        child: SizedBox(
          child: child,
        ),
      ),
    ),
  );
};
