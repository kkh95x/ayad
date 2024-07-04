import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/src/components/dialogs.dart';
import 'package:ayad/src/pages/eyad_download_page.dart';
import 'package:ayad/src/pages/my_notification_page.dart';
import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/pages/slides_page.dart';
import 'package:ayad/src/pages/users_page.dart';
import 'package:ayad/src/providers/get_settings_provider.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/theme.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:flutter/foundation.dart';
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
    final user = ref.watch(authNotifierProvider).value?.currentUser;
    final isAdmin = user?.type == UserType.admin;

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
            user?.username ?? "Username",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: appColor.redish),
          ),
          SizedBox(
            height: 5.h,
          ),
          if (user?.type != UserType.anon)
            Text(
              user?.phone ?? " ",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: appColor.greyish.shade400),
            ),
          SizedBox(
            height: 10.h,
          ),
          if (user?.type != UserType.anon)
            DynamicButton(
              title: "تغيير كلمة المرور",
              onPressed: () async {
                await DilogsHelper.showForgetPasswordForm(context);
              },
            ),
          if (isAdmin) ...[
            SizedBox(
              height: 10.h,
            ),
            DynamicButton(
              title: "عرض قائمة الزبائن",
              onPressed: () {
                if (isAdmin) {
                  context.push(UsersPage.routePath);
                }
              },
            ),
          ],
          // if (isAdmin||ref.watch(authNotifierProvider).value?.currentUser?.type==UserType.customer) ...[
            SizedBox(
              height: 10.h,
            ),
            DynamicButton(
              title: "عرض قائمة الإشعارات",
              onPressed: () {
                
                  context.push(MyNotificationPage.routePath);
                
              },
            ),
          // ],
          if (isAdmin) ...[
            SizedBox(
              height: 10.h,
            ),
            DynamicButton(
              title: "عرض قائمة الإعلانات",
              onPressed: () {
                if (isAdmin) {
                  context.push(SlidesPage.routePath);
                }
              },
            ),
          ],
          if (isAdmin) ...[
            SizedBox(
              height: 10.h,
            ),
            DynamicButton(
              title: "عرض الإعدادات ",
              onPressed: () async {
                if (isAdmin) {
                  await DilogsHelper.showSettingsForm(context);
                }
              },
            ),
          ],
          SizedBox(
            height: 10.h,
          ),
          if(kIsWeb)...[
          DynamicButton(
            // icon: Icon(
            //   Icons.location_on,
            //   color: appColor.whiteish,
            // ),
            title: "مشاركة التطبيق",
            onPressed: () async {
              context.push(EyadDownloadPage.routePath);
            },
          ),
          SizedBox(
            height: 10.h,
          ),],
          DynamicButton(
            // icon: Icon(
            //   Icons.location_on,
            //   color: appColor.whiteish,
            // ),
            title: "عرض موقع",
            onPressed: () async {
              final setting = await ref.read(getSettingFuture.future);
              if (setting != null) {
                double latitude = setting.landtute ?? 36.58365142557628;
                double longitude = setting.longtute ?? 37.04943860000036;
                String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                if (await canLaunchUrl(Uri.parse(googleUrl))) {
                  await launchUrl(Uri.parse(googleUrl));
                } else {}
              }
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          DynamicButton(
            title: "تسجيل الخروج",
            onPressed: () async {
              await ref.read(authNotifierProvider.notifier).logout();
            },
          ),
          SizedBox(height: 30.h,)
        ],
      ),
    ));
  }
}
