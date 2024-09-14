import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/ask_permission.dart';
import 'package:aura/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatelessWidget {
  final ValueNotifier<XFile?> selectedImage;

  const ImageView({super.key, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          selectedImage.value != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                    onTap: () => selectedImage.value = null,
                    child: Image.asset(
                      selectedImage.value!.path,
                      height: context.height * 0.3,
                      width: context.width * 0.7,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Column(
                  children: [
                    CustomButton(
                      width: context.width * 0.7,
                      height: 50,
                      color: AppColors.customGrey,
                      textColor: AppColors.customBlack,
                      text: 'Choose from gallery',
                      borderRadius: 16,
                      hasIcon: true,
                      icon: Icon(IconsaxBold.gallery_add, size: 20.sp),
                      onPressed: () async {
                        final permission = await askPermission(
                            name: 'Photos', permission: Permission.photos);
                        if (permission == true) {
                          selectedImage.value = await picker.pickImage(
                              source: ImageSource.gallery);
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      width: context.width * 0.7,
                      height: 50,
                      color: AppColors.customGrey,
                      textColor: AppColors.customBlack,
                      text: 'Capture with camera',
                      borderRadius: 16,
                      hasIcon: true,
                      icon: Icon(IconsaxBold.camera, size: 20.sp),
                      onPressed: () async {
                        final permission = await askPermission(
                            name: 'Camera', permission: Permission.camera);
                        if (permission == true) {
                          selectedImage.value = await picker.pickImage(
                              source: ImageSource.camera);
                        }
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
