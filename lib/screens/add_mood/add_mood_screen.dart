import 'package:aura/models/local_mood_model.dart';
import 'package:aura/providers/add_mood_provider.dart';
import 'package:aura/utils/moods.dart';
import 'package:aura/widgets/bubble_text_field.dart';
import 'package:aura/widgets/close_button.dart';
import 'package:aura/widgets/custom_button.dart';
import 'package:aura/widgets/custom_tabbar.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import 'components/emoji_view.dart';
import 'components/image_view.dart';
import 'components/text_view.dart';

class AddMoodScreen extends HookConsumerWidget {
  const AddMoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());

    final TabController controller = useTabController(initialLength: 3);
    final moodTextController = useTextEditingController();
    final noteController = useTextEditingController();
    final selectedImage = useState<XFile?>(null);
    final selectedMood = useState<LocalMoodModel>(moods.first);

    final isAnalyzing = ref.watch(addMoodProvider).isLoading;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'How are you feeling today?',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomCloseButton(
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
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
                      'Emoji',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  onTap: (_) {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: [
                    TextView(
                      conroller: moodTextController,
                    ),
                    ImageView(
                      selectedImage: selectedImage,
                    ),
                    EmojiView(
                      selectedMood: selectedMood,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SpeechBubbleTextField(
                controller: noteController,
              ),
              SizedBox(height: 40.h),
              CustomButton(
                  width: context.width * 0.6,
                  height: 50.h,
                  text: 'Analyze',
                  borderRadius: 22,
                  isLoading: isAnalyzing,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await ref.read(addMoodProvider.notifier).handleAnalyze(
                            context: context,
                            type: controller.index == 0
                                ? 'text'
                                : controller.index == 1
                                    ? 'image'
                                    : 'emoji',
                            textController: moodTextController,
                            noteController: noteController,
                            image: selectedImage,
                            emoji: selectedMood,
                          );
                    }
                  }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
