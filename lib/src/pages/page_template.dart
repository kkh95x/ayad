import 'package:ayad/src/pages/home_page.dart';
import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/router.dart';
import 'package:ayad/src/pages/profile_page.dart';
import 'package:ayad/theme.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PageTemplate extends ConsumerWidget {
  const PageTemplate(
      {super.key,
      this.title,
      this.floatingActionButton,
      this.bottomNavigationBar,
      required this.child});
  final String? title;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorProvider = ref.read(appColorLightProvider);
    final goRoute = ref.watch(routeProvider);
    final list =
        goRoute.routeInformationProvider.value.uri.toString().split("/");
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorProvider.whiteish,
        floatingActionButtonLocation: floatingActionButton != null
            ? FloatingActionButtonLocation.centerDocked
            : null,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,

        // ,
        body: SafeArea(
          right: false,
          left: false,
          // bottom: false,
          child: PopScope(
            onPopInvoked: (didPop) {
              if (didPop) {}
            },
            child: Center(
              child: Container(
                decoration: kIsWeb
                    ? BoxDecoration(color: colorProvider.whiteish, boxShadow: [
                        BoxShadow(
                            color: ref
                                .read(appColorLightProvider)
                                .greyish
                                .shade400
                                .withOpacity(.1),
                            blurRadius: 5,
                            offset: const Offset(.1, 0)),
                        BoxShadow(
                            color: ref
                                .read(appColorLightProvider)
                                .greyish
                                .shade400
                                .withOpacity(.1),
                            blurRadius: 5,
                            offset: const Offset(-.1, 0))
                      ])
                    : null,
                margin: EdgeInsets.symmetric(
                    horizontal: kIsWeb
                        ? (MediaQuery.of(context).size.width - 400) / 2
                        : 0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      Assets.png.background.path,
                      fit: BoxFit.fill,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            // print("${list}++++++++++${goRoute.canPop()}+++++++++++++++");
                            // final router = ref.watch(routeProvider);

                            return CustomAppBar(
                              title: title,
                              colorProvider: colorProvider,
                              canPop: (list.length > 2) ? true : false,
                            );
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Expanded(
                          child: child,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar(
      {super.key,
      required this.colorProvider,
      required this.canPop,
      this.onPressedBack,
      this.title});

  final AppColor colorProvider;
  final String? title;
  final bool canPop;
  final void Function()? onPressedBack;
  @override
  Widget build(BuildContext context, ref) {
    // final pageCount = ref.watch(pageCountProvider);
    // ref.watch(selectedTeacherProvider);
    return Container(
        width: 400,
        padding: EdgeInsets.only(right: 25.w, left: 15.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (title != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      context.push(ProfilePage.routePath);
                    },
                    child: Container(
                      width: 52.r,
                      height: 45.r,
                      decoration: BoxDecoration(
                          color: colorProvider.redish.shade300,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: colorProvider.redish, width: 1)),
                      child: Assets.png.logo.image(
                        fit: BoxFit.cover,
                        width: 52.r,
                        height: 45.r,
                      ),
                    ),
                  ),
                  if (title != null) ...[
                    SizedBox(width: 15.w),
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ]
                ],
              )else
              const SizedBox(),

            if (context.canPop()) ...[
              Row(
                children: [
                  Text("رجوع",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 10.sp)),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: onPressedBack ??
                        () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go(HomePage.routePath);
                          }
                        },
                  ),
                ],
              ),
            ],
          ],
        ));
  }
}
