import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/providers/user_providers/user_provider.dart';
import 'package:aura/services/auth_service.dart';
import 'package:aura/widgets/top_bar.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'components/Anonymous_sign_in_button.dart';
import 'components/setting_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final Map<String, dynamic>? metaData = user?.userMetadata;
    final String name = metaData?['name'] ?? 'Unknown';
    final String photo = metaData?['photo'] ??
        'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1726012800&semt=ais_hybrid';

    return Scaffold(
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            if (user?.isAnonymous ?? true) ...[
              SizedBox(height: 30.h),
              const AnonymousSignInButton(),
            ],
            SizedBox(height: user?.isAnonymous ?? true ? 30.h : 40.h),
            // ListTile(
            //   contentPadding: EdgeInsets.zero,
            //   leading: Container(
            //     height: 45.sp,
            //     width: 45.sp,
            //     decoration: BoxDecoration(
            //       color: context.theme.primaryColor,
            //       borderRadius: BorderRadius.circular(15),
            //       boxShadow: [
            //         BoxShadow(
            //           color:
            //               context.isDarkMode ? Colors.black : Colors.grey[400]!,
            //           blurRadius: 0.3,
            //         ),
            //       ],
            //       image: DecorationImage(
            //         fit: BoxFit.cover,
            //         image: CachedNetworkImageProvider(
            //           photo,
            //         ),
            //       ),
            //     ),
            //   ),
            //   title: Text(
            //     name,
            //     style: TextStyle(
            //       fontSize: 14.sp,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            //   subtitle: Text(
            //     user!.isAnonymous ? 'email' : user.email ?? '',
            //     style: TextStyle(
            //       fontSize: 11.sp,
            //     ),
            //   ),
            // ),
            SettingTile(
              title: 'Edit Profile',
              icon: FlutterRemix.user_4_fill,
              color: Colors.blue,
              onPressed: () =>
                  context.push('${Routes.settings}/${Routes.profile}'),
            ),
            SizedBox(height: 15.h),
            SettingTile(
              title: 'Connect socials',
              icon: IconsaxBold.link_2,
              color: AppColors.successColor,
              onPressed: () =>
                  context.push('${Routes.settings}/${Routes.socials}'),
            ),
            SizedBox(height: 15.h),
            SettingTile(
              title: 'Logout',
              icon: IconsaxBold.logout,
              color: AppColors.errorColor,
              onPressed: () async {
                await ref.read(authServiceProvider).logout();
                ref.invalidate(userProvider);
                if (context.mounted) {
                  context.go(Routes.auth);
                }
              },
            ),
            const Spacer(),
            Center(
              heightFactor: 2,
              child: Text(
                'Joined Aura ${timeago.format(
                  DateTime.parse(user?.createdAt ?? DateTime.now().toString()),
                  allowFromNow: true,
                )} ago',
                style: TextStyle(
                  color: AppColors.customBlack.withOpacity(0.5),
                  letterSpacing: 1,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Developed in',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  ' 🇵🇰 ',
                  style: TextStyle(fontSize: 20.sp),
                ),
                Text(
                  ' with ',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  ' ❤️',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
