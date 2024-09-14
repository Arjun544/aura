import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';

import 'core/routes.dart';
import 'providers/common/supabase_provider.dart';
import 'screens/splash_screen.dart';

final providerContainer = ProviderContainer(
  observers: [
    MyObserver(),
  ],
);

void main() async {
  runApp(
    const SplashScreen(),
  );

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await supabaseInit();
  await Future.delayed(const Duration(seconds: 2));

  runApp(
    UncontrolledProviderScope(
      container: providerContainer,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      useInheritedMediaQuery: false,
      child: MaterialApp.router(
        title: 'Aura',
        debugShowCheckedModeBanner: false,
        routerConfig: routes,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: AppColors.customBlack,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          tabBarTheme: TabBarTheme(
            labelStyle: const TextStyle(
              fontSize: 12,
              color: AppColors.customBlack,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              color: Color(0xFF868590),
              fontWeight: FontWeight.w600,
            ),
            labelColor: AppColors.customBlack,
            unselectedLabelColor: const Color(0xFF8E8E91),
            labelPadding: const EdgeInsets.symmetric(vertical: 6),
            indicator: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.customGrey,
            hintStyle: TextStyle(
              fontSize: 13,
              color: AppColors.customBlack.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
            errorStyle: const TextStyle(
              fontSize: 13,
              color: AppColors.errorColor,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.customBlack,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.customBlack,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class MyObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print('Provider $provider was initialized with $value');
    }
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print('Provider $provider was disposed');
    }
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print('Provider $provider updated from $previousValue to $newValue');
    }
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print('Provider $provider threw $error at $stackTrace');
    }
  }
}
