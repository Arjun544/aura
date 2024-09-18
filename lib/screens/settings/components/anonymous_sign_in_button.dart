import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';

class AnonymousSignInButton extends StatelessWidget {
  const AnonymousSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.customGrey,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: 40,
        leading: Icon(
          IconsaxBold.information,
          color: AppColors.errorColor.withOpacity(0.7),
          size: 30.sp,
        ),
        title: Text(
          "Anonymously sign in",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Your data will be lost upon logout out, clear app data or change device.",
            style: TextStyle(
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }
}
