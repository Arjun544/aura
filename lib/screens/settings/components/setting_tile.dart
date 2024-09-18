import '../../../core/imports/core_imports.dart';
import '../../../core/imports/packages_imports.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const SettingTile({
    required this.title,
    required this.icon,
    required this.color,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: color.withAlpha(300),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  icon,
                  color: color,
                  size: 22.sp,
                ),
              ),
            ),
            const SizedBox(width: 18),
            Text(
              title,
              style: TextStyle(
                letterSpacing: 0.5,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
