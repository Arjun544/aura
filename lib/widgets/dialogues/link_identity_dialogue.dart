import 'package:aura/providers/auth_provider.dart';
import 'package:aura/utils/routing_keys.dart';
import 'package:aura/widgets/custom_button.dart';

import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import '../custom_text_button.dart';

class LinkIdentityDialogue extends ConsumerWidget {
  const LinkIdentityDialogue({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(gmailAuthProvider).isLoading;

    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 180.h, horizontal: 15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(height: 10.sp),
                Icon(
                  IconsaxBold.security_safe,
                  size: 45.sp,
                ),
                SizedBox(height: 10.sp),
              ],
            ),
            Column(
              children: [
                Text(
                  'Link Your Google Account',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.sp),
                Text(
                  'We need access to your Google account\nin order to link it with Aura.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CustomButton(
                  width: context.width * 0.7,
                  height: 45.h,
                  text: 'Continue with Google',
                  borderRadius: 20,
                  hasIcon: true,
                  isLoading: isLoading,
                  color: Colors.redAccent[100]!,
                  icon: const Icon(
                    FlutterRemix.google_fill,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await ref
                        .read(gmailAuthProvider.notifier)
                        .linkIdentity(context: context);
                  },
                ),
                SizedBox(height: 10.h),
                CustomTextButton(
                  text: 'Later',
                  color: AppColors.customBlack,
                  size: 13.sp,
                  onPressed: () => rootNavigatorKey.currentState!.pop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
