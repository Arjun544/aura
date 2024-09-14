import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/imports/core_imports.dart';

class CustomCloseButton extends StatelessWidget {
  final VoidCallback onTap;
  final double padding;

  const CustomCloseButton({super.key, required this.onTap, this.padding = 6});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.customGrey,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Icon(
            FlutterRemix.close_fill,
            size: 16.sp,
          ),
        ),
      ),
    );
  }
}
