import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/imports/core_imports.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final double? size;
  final VoidCallback onPressed;

  const CustomTextButton({
    required this.text,
    required this.onPressed,
    required this.color,
    this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size ?? 16.sp,
          color: color,
          letterSpacing: 1,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
