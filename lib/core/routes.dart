import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/main.dart';
import 'package:aura/providers/common/supabase_provider.dart';
import 'package:aura/screens/auth_screen.dart';
import 'package:aura/screens/bottom_nav_screen.dart';
import 'package:aura/screens/calendar/calendar_screen.dart';
import 'package:aura/screens/home/home_screen.dart';
import 'package:aura/screens/settings/profile_screen.dart';
import 'package:aura/screens/settings/settings_screen.dart';
import 'package:aura/screens/settings/socials_screen.dart';
import 'package:aura/screens/splash_screen.dart';
import 'package:aura/screens/stats/Stats_screen.dart';
import 'package:aura/screens/streak/streak_screen.dart';
import 'package:aura/utils/routing_keys.dart';
import 'package:aura/utils/routing_paths.dart';

final routes = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.auth,
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    final client = providerContainer.read(supabaseProvider);
    final authState = client.auth.currentUser;

    // Check if the current route is a auth-related route
    final isAuthRoute = state.fullPath!.startsWith('/auth');

    // If not authenticated, navigate to the auth screen
    if (authState == null) {
      return isAuthRoute ? null : Routes.auth;
    }

    // If authenticated, navigate to the home screen
    if (isAuthRoute) {
      return Routes.home;
    }

    return null;
  },
  routes: [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.splash,
      builder: (context, state) => SplashScreen(
        key: state.pageKey,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.auth,
      builder: (context, state) => AuthScreen(
        key: state.pageKey,
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => BottomNavScreen(
        key: state.pageKey,
        navigationShell: navigationShell,
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: shellNavigatorHome,
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) => HomeScreen(
                key: state.pageKey,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavigatorStreak,
          routes: [
            GoRoute(
              path: Routes.streak,
              builder: (context, state) => StreakScreen(
                key: state.pageKey,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavigatorCalendar,
          routes: [
            GoRoute(
              path: Routes.calendar,
              builder: (context, state) => CalendarScreen(
                key: state.pageKey,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavigatorStats,
          routes: [
            GoRoute(
              path: Routes.stats,
              builder: (context, state) => StatsScreen(
                key: state.pageKey,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavigatorSettings,
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (context, state) => SettingsScreen(
                key: state.pageKey,
              ),
              routes: [
                GoRoute(
                  path: Routes.profile,
                  builder: (context, state) => ProfileScreen(
                    key: state.pageKey,
                  ),
                ),
                GoRoute(
                  path: Routes.socials,
                  builder: (context, state) => SocialsScreen(
                    key: state.pageKey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
