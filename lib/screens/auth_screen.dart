import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/providers/auth_provider.dart';
import 'package:aura/widgets/custom_button.dart';
import 'package:blobs/blobs.dart';
import 'package:lottie/lottie.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAnonymousLoading = ref.watch(anonymousAuthProvider).isLoading;
    final isGmailLoading = ref.watch(gmailAuthProvider).isLoading;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Blob.animatedRandom(
            size: context.height * 0.4,
            loop: true,
            duration: const Duration(seconds: 1),
            styles: BlobStyles(
              color: AppColors.customGrey,
            ),
            child: Center(
              child: Lottie.asset(
                AssetsManager.logoAnimation,
                height: context.height * 0.25,
              ),
            ),
          ).animate().slideX(duration: 500.ms).fade(duration: 500.ms),
          Column(
            children: [
              Center(
                child: Text(
                  'Aura',
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.customBlack,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Text(
                'Visualize Your Feelings, Own Your Day',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.customBlack.withOpacity(0.4),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 2000.ms),
            ],
          ),
          Column(
            children: [
              CustomButton(
                width: context.width * 0.9,
                text: 'Continue Anonymously',
                borderRadius: 20,
                marginBottom: 20,
                color: AppColors.customGrey,
                isLoading: isAnonymousLoading,
                hasIcon: true,
                textColor: AppColors.customBlack,
                icon: const Icon(
                  FlutterRemix.user_4_fill,
                  color: AppColors.customBlack,
                ),
                onPressed: () async {
                  await ref
                      .read(anonymousAuthProvider.notifier)
                      .loginAnonymously(context: context);
                },
              ),
              CustomButton(
                width: context.width * 0.9,
                text: 'Continue with Google',
                borderRadius: 20,
                hasIcon: true,
                isLoading: isGmailLoading,
                color: Colors.redAccent[100]!,
                icon: const Icon(
                  FlutterRemix.google_fill,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await ref
                      .read(gmailAuthProvider.notifier)
                      .loginWithGoogle(context: context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
