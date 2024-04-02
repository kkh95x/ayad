import 'package:ayad/router.dart';
import 'package:ayad/theme.dart';
import 'package:ayad/users/auth/shared_prefrance_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PackageInfo.fromPlatform();
  await SharedPrefranceServce.initial();
  await Supabase.initialize(
      url: "https://vrclircgjpkyvnvsonwn.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZyY2xpcmNnanBreXZudnNvbnduIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTEyNzY0MzEsImV4cCI6MjAyNjg1MjQzMX0.QH1TTUIVnOOF56Z708MCRXXKKeJLW9BvjVrv3Pv5P_Q");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final botToastBuilder = BotToastInit();

    final router = ref.watch(routeProvider);

    return ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) {
              child = botToastBuilder(context, child);

              // child = ResponsiveBreakpoints.builder(
              //   child: child,
              //   breakpoints: [
              //     const Breakpoint(start: 0, end: 450, name: MOBILE),
              //     const Breakpoint(start: 451, end: 800, name: TABLET),
              //     const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              //     const Breakpoint(
              //         start: 1921, end: double.infinity, name: '4K'),
              //   ],
              // );
              return child;
            },
            supportedLocales: const [
              Locale('ar', 'AE'),
            ],
            themeMode: ThemeMode.light,
            theme: lightThemeData,
            routerConfig: router,
          );
        });
  }
}
