import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';

class SpeechBubbleTextField extends StatelessWidget {
  final TextEditingController controller;

  const SpeechBubbleTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.6,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomRight,
        children: [
          Positioned(
            bottom: -8,
            left: 10,
            child: Container(
              width: 15.h,
              height: 16.h,
              decoration: const BoxDecoration(
                color: AppColors.customGrey,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -25,
            left: 20,
            child: Container(
              width: 10.h,
              height: 10.h,
              decoration: const BoxDecoration(
                color: AppColors.customGrey,
                shape: BoxShape.circle,
              ),
            ),
          ),
          TextField(
            controller: controller,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            textCapitalization: TextCapitalization.sentences,
            cursorColor: AppColors.customBlack,
            cursorWidth: 4,
            maxLines: 5,
            minLines: 1,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.customGrey,
              hintText: 'Thoughts about your mood...',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
