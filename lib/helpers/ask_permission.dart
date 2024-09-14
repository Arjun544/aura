import 'dart:developer';

import 'package:aura/utils/routing_keys.dart';
import 'package:permission_handler/permission_handler.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';
import '../widgets/dialogues/request_permission_dialogue.dart';

Future<bool> askPermission({
  required String name,
  required Permission permission,
}) async {
  String? title;
  String? description;
  IconData? icon;

  switch (name) {
    case 'Camera':
      title = "Capture the Mood";
      description =
          'To take photos within Aura, please allow access to your camera';
      icon = IconsaxBold.camera;
      break;

    case 'Photos':
      title = "Choose Your Mood";
      description =
          'To share your stunning moments on Aura, please grant access to your photos';
      icon = IconsaxBold.gallery_add;
      break;

    case 'Microphone':
      title = "Speak the Moment";
      description =
          'To record your voice on Aura, please grant access to your microphone';
      icon = IconsaxBold.microphone;
      break;

    default:
  }

  final status = await permission.status;

  if (status.isGranted) {
    log('$name permission: Granted');
    return true;
  } else if (status.isDenied) {
    bool? isGranted;
    await _showPermissionDialog(name, title!, description!, icon!, 'Allow',
        () async {
      final result = await permission.request();
      if (result.isGranted == true) {
        isGranted = true;
        Navigator.of(rootNavigatorKey.currentContext!, rootNavigator: true)
            .pop();
      } else {
        await openAppSettings();

        isGranted = false;
        Navigator.of(rootNavigatorKey.currentContext!, rootNavigator: true)
            .pop();
      }
    });

    return isGranted!;
  } else {
    log('$name permission: Permanently Denied');
    await _showPermissionDialog(name, title!, description!, icon!, 'Settings',
        () async {
      Navigator.of(rootNavigatorKey.currentContext!, rootNavigator: true).pop();

      await openAppSettings();
    });
    return false;
  }
}

Future<void> _showPermissionDialog(
    String name,
    String title,
    String description,
    IconData icon,
    String btnText,
    VoidCallback onPressed) async {
  await showGeneralDialog<bool>(
    context: rootNavigatorKey.currentContext!,
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
      opacity: animation,
      child: RequestPermissionDialogue(
        name: name,
        title: title,
        description: description,
        btnText: btnText,
        icon: icon,
        onPressed: onPressed,
      ),
    ),
  );
}
