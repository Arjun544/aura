import 'dart:async';

import 'package:aura/helpers/show_toast.dart';
import 'package:aura/providers/common/supabase_provider.dart';
import 'package:aura/providers/user_providers/user_provider.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';
import '../widgets/custom_nav_bar/custom_navigation_bar.dart';

class BottomNavScreen extends HookConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    StreamSubscription? subscription;

    useEffect(() {
      subscription = ref.read(supabaseProvider).auth.onAuthStateChange.listen(
        (event) {
          if (event.event == AuthChangeEvent.signedIn) {
            if (event.session?.user != null &&
                event.session?.user.isAnonymous == false) {
              showToast(
                context,
                message: 'Identity linked successfully',
                status: 'success',
              );
            }

            ref.read(userProvider.notifier).update(
                  (state) => event.session!.user,
                );
          }
        },
        onError: (e) {
          final AuthException authException = e as AuthException;
          logError('AuthException Error : $e');
          if (authException.message == 'Identity is already linked') {
            showToast(
              context,
              message: 'Account is already linked',
              status: 'error',
            );
          } else if (authException.message ==
              'Identity is already linked to another user') {
            showToast(
              context,
              message: 'Account is already linked to another user',
              status: 'error',
            );
          }
        },
      );

      return () {
        subscription?.cancel();
      };
    }, const []);

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
