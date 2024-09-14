import 'package:aura/widgets/custom_text_button.dart';

import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import '../custom_button.dart';

class RequestPermissionDialogue extends StatelessWidget {
  final String name;
  final String title;
  final String description;
  final String btnText;
  final IconData icon;
  final VoidCallback onPressed;

  const RequestPermissionDialogue({
    required this.name,
    required this.title,
    required this.description,
    required this.btnText,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: context.height * 0.2,
          horizontal: 15.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(height: 10.sp),
                Icon(
                  IconsaxBold.security_safe,
                  size: 40.sp,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.customBlack.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 10,
                  child: Container(
                    height: context.height * 0.1,
                    width: context.height * 0.37,
                    decoration: BoxDecoration(
                      color: AppColors.customGrey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  child: Container(
                    height: context.height * 0.1,
                    width: context.height * 0.34,
                    decoration: BoxDecoration(
                      color: AppColors.customGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.customGrey,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0.5,
                        blurRadius: 4,
                        offset: const Offset(0, 0.1),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Icon(
                      icon,
                      size: 30.sp,
                    ),
                    title: Text(
                      'Allow ${name.toLowerCase()} access',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Aura needs access to your ${name.toLowerCase()}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.customBlack.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.h),
            Column(
              children: [
                CustomTextButton(
                  text: 'Later',
                  color: context.theme.textTheme.labelSmall!.color!
                      .withOpacity(0.4),
                  size: 12.sp,
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                ),
                SizedBox(height: 5.h),
                CustomButton(
                  height: 35.h,
                  width: context.width * 0.3,
                  text: btnText,
                  color: AppColors.primary,
                  borderRadius: 16.r,
                  onPressed: onPressed,
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
