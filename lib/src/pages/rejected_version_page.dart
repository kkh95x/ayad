import 'dart:io';

import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/src/providers/get_settings_provider.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class RejectedVersionPage extends ConsumerWidget {
  const RejectedVersionPage({
    super.key,
  });
  static String get routeName => "reject-version";
  static String get routePath => "/$routeName";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      color: Theme.of(context).colorScheme.onPrimary,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              Assets.svg.needUpdate,
              repeat: true,
              reverse: false,
              animate: true,
            ),
            Text(
              "الإصدار الحالي قديم",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "يرجى تحديث التطبيق إلى أحدث إصدار والمحاولة مجدداَ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            if (!kIsWeb && Platform.isAndroid) ...[
              const SizedBox(
                height: 20,
              ),
              DynamicButton(
                title: "تحديث",
                height: 40,
                onPressed: () async {
                  final setting = await ref.read(getSettingFuture.future);
                  if (setting != null) {
                    final urlPlayStore = Uri.parse(setting.apkUrl);
                    if (await canLaunchUrl(urlPlayStore)) {
                      launchUrl(urlPlayStore);
                    }
                  }
                },
              )
            ]
          ],
        ),
      ),
    );
  }
}
