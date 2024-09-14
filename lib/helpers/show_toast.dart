import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';
import '../widgets/toast/imports.dart';

void showToast(
  BuildContext context, {
  required String message,
  String? status = 'success',
  IconData? icon,
  bool? autoDismiss,
}) {
  return ToastBar(
    position: ToastPosition.top,
    autoDismiss: autoDismiss ?? true,
    toastDuration: const Duration(seconds: 2),
    animationDuration: const Duration(milliseconds: 150),
    animationCurve: Curves.easeIn,
    builder: (context) => ToastCard(
      color: status == 'error' ? AppColors.errorColor : Colors.white,
      shadowColor: AppColors.customGrey,
      leading: Icon(
        icon ??
            (status == 'success'
                ? IconsaxBold.tick_circle
                : status == 'error'
                    ? IconsaxBold.danger
                    : IconsaxBold.info_circle),
        color: status == 'error'
            ? Colors.white
            : status == 'info'
                ? Colors.orange
                : status == 'success'
                    ? AppColors.successColor
                    : AppColors.customBlack,
        size: 22.sp,
      ),
      title: Text(
        message,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: status == 'error' ? Colors.white : AppColors.customBlack,
        ),
      ),
    ),
  ).show(context);
}
