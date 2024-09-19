// ignore_for_file: use_build_context_synchronously

import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/helpers/show_toast.dart';
import 'package:aura/utils/routing_keys.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

(Future<void> Function(String), bool) useCopy() {
  final hasCopied = useState(false);

  Future<void> copyToClipboard(String text) async {
    try {
      hasCopied.value = true;
      await Clipboard.setData(ClipboardData(text: text));
      showToast(
        rootNavigatorKey.currentState!.context,
        message: 'Copied successfully',
        status: 'success',
      );
      await Future.delayed(
          const Duration(seconds: 2), () => hasCopied.value = false);
    } catch (e) {
      logError('Error copying to clipboard: $e');
      hasCopied.value = false;
      showToast(
        rootNavigatorKey.currentState!.context,
        message: 'Failed to copy',
        status: 'error',
      );
    }
  }

  useEffect(() {
    return () {
      hasCopied.value = false;
    };
  }, []);

  return (copyToClipboard, hasCopied.value);
}
