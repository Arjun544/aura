import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';
import '../widgets/custom_nav_bar/custom_navigation_bar.dart';

class BottomNavScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CustomNavigationBar(
        iconSize: 24.sp,
        scaleFactor: 0.4,
        elevation: 20,
        selectedColor: AppColors.primary,
        strokeColor: Colors.transparent,
        unSelectedColor: AppColors.customGrey,
        backgroundColor: Colors.white,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: <NavItem>[
          NavItem(
            icon: IconsaxBold.home_2,
            title: 'Home',
          ),
          NavItem(
            icon: FlutterRemix.fire_fill,
            title: 'Streaks',
          ),
          NavItem(
            icon: IconsaxBold.calendar_2,
            title: 'Calendar',
          ),
          NavItem(
            icon: IconsaxBold.chart_2,
            title: 'Stats',
          ),
          NavItem(
            icon: IconsaxBold.setting,
            title: 'Settings',
          ),
        ]
            .map(
              (item) => CustomNavigationBarItem(
                icon: Icon(
                  item.icon,
                  size: 22.h,
                ),
                title: SizedBox(height: 20.h),
              ),
            )
            .toList(),
      ),
    );
  }
}

class NavItem {
  NavItem({
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;
}
