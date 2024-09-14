import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/widgets/custom_button.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          CustomButton(
            width: context.width * 0.5,
            height: 50,
            color: AppColors.customGrey,
            textColor: AppColors.customBlack,
            text: 'Add Image',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
