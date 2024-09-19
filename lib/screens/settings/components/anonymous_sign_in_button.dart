import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/widgets/custom_dialogue.dart';
import 'package:aura/widgets/dialogues/link_identity_dialogue.dart';

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
        titleAlignment: ListTileTitleAlignment.titleHeight,
        leading: Icon(
          IconsaxBold.info_circle,
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Your data will be lost upon logout out, clear app data or change device.",
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => showCustomDialogue(
                child: const LinkIdentityDialogue(),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Text(
                  'Link Your Google Account',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.errorColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
