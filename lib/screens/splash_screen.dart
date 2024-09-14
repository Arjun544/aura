import 'package:flutter_svg/svg.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: context.width,
          height: context.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(0.5),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              Hero(
                tag: 'Logo',
                child: SvgPicture.asset(
                  AssetsManager.appLogo,
                  height: 120,
                ),
              ),
              // Column(
              //   children: [
              //     Hero(
              //       tag: 'Logo',
              //       child: SvgPicture.asset(
              //         AssetsManager.appLogo,
              //         height: 50,
              //         colorFilter: const ColorFilter.mode(
              //           Colors.white,
              //           BlendMode.srcIn,
              //         ),
              //         theme: const SvgTheme(
              //           currentColor: Colors.white,
              //         ),
              //       ),
              //     ),
              //     const SizedBox(height: 14),
              //     Text(
              //       'Meetox',
              //       style: context.theme.textTheme.titleLarge!.copyWith(
              //         letterSpacing: 1,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
