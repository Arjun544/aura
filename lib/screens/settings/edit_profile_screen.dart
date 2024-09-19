import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/show_toast.dart';
import 'package:aura/providers/common/supabase_provider.dart';
import 'package:aura/providers/user_providers/user_provider.dart';
import 'package:aura/widgets/custom_app_bar.dart';
import 'package:aura/widgets/custom_text_button.dart';
import 'package:aura/widgets/custom_text_field.dart';
import 'package:timeago/timeago.dart' as timeago;

class EditProfileScreen extends HookConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final Map<String, dynamic>? metaData = user?.userMetadata;

    final List<UserIdentity> identities = user?.identities ?? [];

    final String name = metaData?['name'] == null
        ? identities.isEmpty
            ? 'Unknown'
            : identities.first.identityData != null
                ? identities.first.identityData!['name']
                : metaData!['name']
        : metaData!['name'];

    final nameController = useTextEditingController(
      text: name,
    );

    final isSaveEnabled = useListenableSelector(
      nameController,
      () => nameController.text.isNotEmpty && name != nameController.text,
    );

    void updateName() async {
      await ref.read(supabaseProvider).auth.updateUser(
            UserAttributes(
              data: {
                'name': nameController.text.trim(),
              },
            ),
          );

      ref.invalidate(userProvider);
      if (context.mounted) {
        showToast(
          context,
          message: 'Name updated',
          status: 'success',
        );
      }
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Edit Profile',
          actions: [
            CustomTextButton(
              text: 'Save',
              size: 12.sp,
              onPressed: isSaveEnabled ? updateName : () {},
              color: isSaveEnabled
                  ? AppColors.customBlack
                  : AppColors.customBlack.withOpacity(0.5),
            ),
            SizedBox(width: 10.w),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              CustomTextField(
                hintText: 'Name',
                controller: nameController,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 15.h),
              buildTile(
                context: context,
                title: 'Email',
                subtitle: '',
              ),
              SizedBox(height: 15.h),
              buildTile(
                context: context,
                title: 'Email Verified',
                subtitle: user!.emailConfirmedAt == null
                    ? ''
                    : '${timeago.format(
                        DateTime.parse(user.emailConfirmedAt!),
                        allowFromNow: true,
                      )} ago',
              ),
              SizedBox(height: 15.h),
              buildTile(
                context: context,
                title: 'Last Updated',
                subtitle: user.updatedAt == null
                    ? ''
                    : '${timeago.format(
                        DateTime.parse(user.updatedAt!),
                        allowFromNow: true,
                      )} ago',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTile({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.customGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.theme.textTheme.labelMedium!.copyWith(
              fontSize: 11.sp,
              color:
                  context.theme.textTheme.labelMedium!.color!.withOpacity(0.4),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            subtitle,
            style: context.theme.textTheme.labelMedium!.copyWith(
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
