import 'package:flutter/services.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';

class CustomTextField extends HookWidget {
  const CustomTextField({
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.prefixIcon,
    super.key,
    this.autoFocus = true,
    this.capitalize = TextCapitalization.sentences,
    this.formats,
    this.validator,
    this.onChanged,
    this.onClear,
    this.onSubmit,
  });
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final bool autoFocus;
  final TextCapitalization capitalize;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? formats;
  final String? Function(String?)? validator;
  final VoidCallback? onClear;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final isPasswordVisible = useState(false);
    final showClearIcon = useListenable(focusNode);
    final bool textIsEmpty =
        useListenableSelector(controller, () => controller.text.isEmpty);

    return TextFormField(
      inputFormatters: formats,
      controller: controller,
      focusNode: focusNode,
      obscureText: isPasswordVisible.value,
      textCapitalization: capitalize,
      keyboardType: keyboardType,
      style: context.theme.textTheme.labelMedium!.copyWith(
        fontSize: 12.sp,
      ),
      cursorColor: AppColors.customBlack,
      cursorWidth: 3,
      textInputAction: TextInputAction.done,
      textAlignVertical: TextAlignVertical.center,
      autofocus: autoFocus,
      decoration: InputDecoration(
        filled: context.theme.inputDecorationTheme.filled,
        fillColor: context.theme.inputDecorationTheme.fillColor,
        hintText: hintText,
        hintStyle: context.theme.inputDecorationTheme.hintStyle,
        errorStyle: context.theme.inputDecorationTheme.errorStyle,
        border: context.theme.inputDecorationTheme.border,
        focusedBorder: context.theme.inputDecorationTheme.focusedBorder,
        enabledBorder: context.theme.inputDecorationTheme.enabledBorder,
        focusedErrorBorder:
            context.theme.inputDecorationTheme.focusedErrorBorder,
        suffixIconConstraints: const BoxConstraints(
          minHeight: 0,
          minWidth: 20,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        prefixIcon: prefixIcon != null
            ? IconTheme(
                data: context.theme.iconTheme.copyWith(color: Colors.grey),
                child: Icon(prefixIcon),
              )
            : null,
        suffixIcon: IconTheme(
          data: context.theme.iconTheme.copyWith(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: showClearIcon.hasPrimaryFocus && !textIsEmpty
                ? InkWell(
                    onTap: () {
                      controller.clear();
                      if (onClear != null) {
                        onClear!();
                      }
                    },
                    child: const Icon(FlutterRemix.close_circle_fill),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        isDense: context.theme.inputDecorationTheme.isDense,
      ),
      validator: validator,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      onFieldSubmitted: onSubmit,
    );
  }
}
