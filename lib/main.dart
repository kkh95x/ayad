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
import 'package:firebase_messaging/firebase_messaging.dart';

// Import the generated file
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PackageInfo.fromPlatform();
  await SharedPrefranceServce.initial();
  await Supabase.initialize(
      url: "https://vrclircgjpkyvnvsonwn.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZyY2xpcmNnanBreXZudnNvbnduIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTEyNzY0MzEsImV4cCI6MjAyNjg1MjQzMX0.QH1TTUIVnOOF56Z708MCRXXKKeJLW9BvjVrv3Pv5P_Q");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      BotToast.closeAllLoading();
      BotToast.showSimpleNotification(
        title: message.notification!.title!,
        subTitle: message.notification!.body,
        duration: const Duration(seconds: 10),
        backgroundColor: Colors.grey.shade200,
      );
      print(
          'Message also contained a notification: ${message.notification?.title} ${message.notification?.body}');
    }
  });
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   final title = event.notification?.title;
    //   final body = event.notification?.body;
    //   print(event.toMap());
    //   if (title != null && body != null) {
    //     BotToast.showSimpleNotification(title: title, subTitle: body);
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
