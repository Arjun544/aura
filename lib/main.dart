import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/core/time_ago_messages.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'core/routes.dart';
import 'core/themes/themes.dart';
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
  timeago.setLocaleMessages('en', TimeAgoMessages());
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

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      child: MaterialApp.router(
        title: 'Aura',
        debugShowCheckedModeBanner: false,
        routerConfig: routes,
        themeMode: ThemeMode.light,
        theme: Themes.lightTheme,
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
