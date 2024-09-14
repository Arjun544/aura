import 'package:aura/widgets/custom_button.dart';
import 'package:aura/widgets/custom_tabbar.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import 'components/emoji_view.dart';
import 'components/image_view.dart';
import 'components/text_view.dart';
import 'components/voice_view.dart';

class AddMoodScreen extends HookWidget {
  const AddMoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TabController controller = useTabController(initialLength: 4);
    final selectedImage = useState<XFile?>(null);

    return Container(
      height: context.height * 0.9,
      width: context.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              'How are you feeling today?',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomTabbar(
              controller: controller,
              tabs: [
                Text(
                  'Text',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Image',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Voice',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Emoji',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              onTap: (_) {},
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: [
                const TextView(),
                ImageView(
                  selectedImage: selectedImage,
                ),
                const VoiceView(),
                const EmojiView(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            width: context.width * 0.5,
            height: 50,
            text: 'Add Mood',
            borderRadius: 18,
            onPressed: () {},
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
