import 'package:aura/core/imports/core_imports.dart';

class TextView extends StatelessWidget {
  const TextView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        maxLines: 5,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          filled: context.theme.inputDecorationTheme.filled,
          fillColor: context.theme.inputDecorationTheme.fillColor,
          hintText: 'Type your thoughts here',
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
    );
  }
}
