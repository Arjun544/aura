import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(title.capitalizeFirst!,
          style: TextStyle(
            color: AppColors.customBlack,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          )),
      leading: context.canPop() || onPressed != null
          ? GestureDetector(
              onTap: () => onPressed != null
                  ? onPressed!()
                  : context.canPop()
                      ? context.pop()
                      : null,
              child: Container(
                color: Colors.transparent,
                child: const Icon(
                  IconsaxBold.arrow_left_3,
                  color: AppColors.customBlack,
                ),
              ),
            )
          : null,
      iconTheme: const IconThemeData(
        color: AppColors.customBlack,
      ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
