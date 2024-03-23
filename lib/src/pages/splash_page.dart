import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});
static String get routeName=>"splash";
 static String get routePath=>"/$routeName";
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: Container(
        color:ref.read(appColorLightProvider).redish ,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Center(
          child:Assets.png.logoWhite.image(fit: BoxFit.fitWidth) ,
        ),
      ),
    );
  }
}