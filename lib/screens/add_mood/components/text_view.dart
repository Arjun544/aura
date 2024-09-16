import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';

class TextView extends StatelessWidget {
  final TextEditingController conroller;
  const TextView({super.key, required this.conroller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          controller: conroller,
          maxLines: 5,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onTap: () => FocusScope.of(context).unfocus(),
          textCapitalization: TextCapitalization.sentences,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          cursorColor: AppColors.customBlack,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please describe your mood';
            }

            if (value.length < 10) {
              return 'Please enter at least 10 characters';
            }
            return null;
          },
          decoration: InputDecoration(
            filled: context.theme.inputDecorationTheme.filled,
            fillColor: context.theme.inputDecorationTheme.fillColor,
            hintText: 'Type what you are feeling ...',
            hintStyle: context.theme.inputDecorationTheme.hintStyle,
            errorStyle: context.theme.inputDecorationTheme.errorStyle,
            border: context.theme.inputDecorationTheme.border,
            focusedBorder: context.theme.inputDecorationTheme.focusedBorder,
            enabledBorder: context.theme.inputDecorationTheme.enabledBorder,
            focusedErrorBorder:
                context.theme.inputDecorationTheme.focusedErrorBorder,
            isDense: context.theme.inputDecorationTheme.isDense,
          ),
        ),
      ),
    );
  }
}
