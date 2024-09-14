import '../../../core/imports/core_imports.dart';

/// ToastCard widget to display decent and rich looking snackbar
class ToastCard extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Color? color;
  final Color? shadowColor;
  final Function()? onTap;
  const ToastCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.color,
    this.shadowColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.theme.indicatorColor),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 3,
            offset: Offset.zero,
            color: shadowColor ?? Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: leading,
        ),
        trailing: trailing,
        subtitle: subtitle,
        title: title,
        onTap: onTap,
      ),
    );
  }
}
