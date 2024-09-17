import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';

import 'calendar_timeline.dart';

class CalendarView extends HookWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDate = useState(DateTime.now());

    return Column(
      children: [
        CalendarTimeline(
          selectedDate: selectedDate,
        ),
      ],
    );
  }
}
