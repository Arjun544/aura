import 'package:aura/providers/calendar_providers/calendar_provider.dart';
import 'package:aura/screens/add_mood/add_mood_screen.dart';
import 'package:aura/widgets/custom_sheet.dart';

import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import '../../providers/common/supabase_provider.dart';
import '../../widgets/top_bar.dart';
import 'components/calendar_view.dart';
import 'components/mood_list_view.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const TopBar(),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: layout == 'calendar'
                    ? const CalendarView(
                        key: ValueKey('calendar view'),
                      )
                    : const MoodsListView(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'events_layout',
            elevation: 0,
            backgroundColor: AppColors.customGrey,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              ),
              child: layout == 'calendar'
                  ? Icon(
                      key: const ValueKey('list'),
                      FlutterRemix.menu_5_fill,
                      color: AppColors.customBlack,
                      size: 24.sp,
                    )
                  : Icon(
                      key: const ValueKey('calendar'),
                      IconsaxBold.calendar,
                      color: AppColors.customBlack,
                      size: 24.sp,
                    ),
            ),
            onPressed: () async {
              await ref.watch(supabaseProvider).auth.updateUser(
                    UserAttributes(
                      data: {
                        'events_layout': layout == 'list' ? 'calendar' : 'list',
                      },
                    ),
                  );

              ref.read(layoutProvider.notifier).state =
                  layout == 'list' ? 'calendar' : 'list';
            },
          ),
          SizedBox(height: 10.h),
          FloatingActionButton(
            elevation: 0,
            backgroundColor: AppColors.primary,
            child: const Icon(
              FlutterRemix.user_smile_fill,
              size: 28,
              color: AppColors.customBlack,
            ),
            onPressed: () => showCustomSheet(child: const AddMoodScreen()),
          ),
        ],
      ),
    );
  }
}
