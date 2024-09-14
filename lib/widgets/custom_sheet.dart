import 'dart:ui';

import 'package:aura/utils/routing_keys.dart';

import '../core/imports/core_imports.dart';

Future<void> Function({
  required Widget child,
  bool hasBlur,
  bool enableDrag,
}) showCustomSheet = ({
  required Widget child,
  bool hasBlur = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet(
    context: rootNavigatorKey.currentContext!,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor:
        rootNavigatorKey.currentContext!.theme.indicatorColor.withOpacity(0.2),
    elevation: 0,
    useSafeArea: true,
    enableDrag: enableDrag,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    builder: (context) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: hasBlur ? 3 : 0,
          sigmaY: hasBlur ? 3 : 0,
        ),
        child: SizedBox(
          child: child,
        ),
      ),
    ),
  );
};
