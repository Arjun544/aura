import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';

class CustomTabbar extends StatelessWidget {
  const CustomTabbar({
    required this.controller,
    required this.tabs,
    required this.onTap,
    super.key,
  });
  final TabController controller;
  final List<Widget> tabs;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 35.h,
      decoration: BoxDecoration(
        color: context.theme.indicatorColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        onTap: onTap,
        indicatorSize: TabBarIndicatorSize.tab,
        controller: controller,
        dividerHeight: 0,
        tabs: tabs,
      ),
    );
  }
}
