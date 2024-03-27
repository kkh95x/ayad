import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/src/components/dialogs.dart';
import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/pages/slides_page.dart';
import 'package:ayad/src/pages/users_page.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/theme.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});
  static String get routeName => "profile";
  static String get routePath => "/$routeName";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return PageTemplate(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.png.person.image(
              height: 200.h, width: double.infinity, fit: BoxFit.fitHeight),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Username",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: appColor.redish),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "+31637031781",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w400, color: appColor.greyish.shade400),
          ),
          SizedBox(
            height: 10.h,
          ),
          DynamicButton(
            title: "تغيير كلمة المرور",
            onPressed: () async {
              await DilogsHelper.showForgetPasswordForm(context);
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          DynamicButton(
            title: "عرض قائمة الزبائن",
            onPressed: () {
              context.push(UsersPage.routePath);
            },
          ),
           SizedBox(
            height: 10.h,
          ),
          DynamicButton(
            title: "عرض قائمة الإعلانات",
            onPressed: () {
              context.push(SlidesPage.routePath);
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          DynamicButton(
            title: "عرض الأعدادات ",
            onPressed: () async {
              await DilogsHelper.showSettingsForm(context);
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          DynamicButton(
            // icon: Icon(
            //   Icons.location_on,
            //   color: appColor.whiteish,
            // ),
            title: "عرض موقع المتجر على الخريطة",
            onPressed: () async {
              double latitude=36.58741348746436;
              double longitude= 37.04609160000916;
              String googleUrl =
                  'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
              if (await canLaunchUrl(Uri.parse(googleUrl))) {
                await launchUrl(Uri.parse(googleUrl));
              } else {}
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          DynamicButton(
            title: "تسجيل الخروج",
            onPressed: () async{
              await ref.read(authNotifierProvider.notifier).logout();
            },
          ),
        ],
      ),
    ));
  }
}
