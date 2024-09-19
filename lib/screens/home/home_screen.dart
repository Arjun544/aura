import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/providers/mood_providers/moods_provider.dart';
import 'package:aura/providers/streak_providers.dart';
import 'package:aura/providers/user_providers/user_provider.dart';
import 'package:aura/screens/add_mood/add_mood_screen.dart';
import 'package:aura/widgets/custom_sheet.dart';
import 'package:aura/widgets/top_bar.dart';

import 'components/happy_percentage_section.dart';
import 'components/recommended_activities_section.dart';
import 'components/this_week_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const TopBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dayMoodProvider);
          ref.invalidate(userProvider);
          ref.invalidate(streakCountProvider);
          ref.invalidate(happyPercentageProvider);
        },
        color: AppColors.primary,
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: const [
            ThisWeekSection(),
            HappyPercentageSection(),
            RecommendedActivitiesSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: AppColors.primary,
        child: const Icon(
          FlutterRemix.user_smile_fill,
          size: 28,
          color: AppColors.customBlack,
        ),
        onPressed: () => showCustomSheet(child: const AddMoodScreen()),
      ),
    );
  }
}
