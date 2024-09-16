import 'dart:io';

import 'package:aura/helpers/ask_permission.dart';
import 'package:aura/helpers/show_toast.dart';
import 'package:aura/providers/streak_providers.dart';
import 'package:aura/providers/user_providers/user_provider.dart';
import 'package:aura/services/user_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';

class TopBar extends ConsumerWidget implements PreferredSizeWidget {
  final double topPadding;

  const TopBar({
    super.key,
    this.topPadding = 50,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void selectImage() async {
      final hasPermission =
          await askPermission(name: 'Photos', permission: Permission.photos);
      if (hasPermission) {
        final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
        );
        if (image != null) {
          final res = await ref.read(userServiceProvider).updateImage(
                file: File(image.path),
              );

          res.mapBoth(
            onLeft: (l) {
              logError(l.toString());
              showToast(context,
                  message: 'Failed to upload image', status: 'error');
            },
            onRight: (data) {
              ref.invalidate(userProvider);
            },
          );
        }
      }
    }

    return Container(
      height: kToolbarHeight,
      width: context.width,
      margin: EdgeInsets.only(
        top: Platform.isIOS ? topPadding.sp : 40.sp,
        right: 15.sp,
        left: 15.sp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer(
            builder: (context, ref, child) {
              final Map<String, dynamic>? metaData =
                  ref.watch(userProvider)?.userMetadata;
              final String photo = metaData?['photo'] ??
                  'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1726012800&semt=ais_hybrid';

              return InkWell(
                onTap: () => selectImage(),
                child: Container(
                  height: 45.sp,
                  width: 45.sp,
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: context.isDarkMode
                            ? Colors.black
                            : Colors.grey[400]!,
                        blurRadius: 0.3,
                      ),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        photo,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () => context.go(Routes.streak),
            child: Container(
              height: 45.sp,
              width: 55.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.customGrey,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FlutterRemix.fire_fill,
                    size: 22.sp,
                    color: Colors.orangeAccent,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    ref.watch(streakCountProvider).valueOrNull?.toString() ??
                        '0',
                    style: TextStyle(
                      color: AppColors.customBlack,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ).animate().fadeIn(duration: 500.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
