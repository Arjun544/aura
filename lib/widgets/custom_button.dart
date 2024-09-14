import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../core/imports/core_imports.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double? height;
  final String? text;
  final Color color;
  final double? borderRadius;
  final Color? textColor;
  final Widget icon;
  final bool hasIcon;
  final bool isLoading;
  final double loaderSize;
  final double marginBottom;
  final VoidCallback onPressed;

  const CustomButton({
    required this.width,
    this.text,
    required this.onPressed,
    super.key,
    this.height,
    this.icon = const SizedBox.shrink(),
    this.borderRadius = 20,
    this.hasIcon = false,
    this.isLoading = false,
    this.loaderSize = 20,
    this.marginBottom = 0,
    this.color = AppColors.customBlack,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width,
        height: height ?? 50.h,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: marginBottom),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
        ),
        child: isLoading
            ? LoadingAnimationWidget.staggeredDotsWave(
                color: textColor ?? Colors.white,
                size: loaderSize,
              )
            : text == null
                ? icon
                : hasIcon
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          icon,
                          SizedBox(
                            width: 20.sp,
                          ),
                          Text(
                            text ?? '',
                            style: TextStyle(
                              color: textColor,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        text ?? '',
                        style: TextStyle(
                          color: textColor,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
      ),
    );
  }
}
