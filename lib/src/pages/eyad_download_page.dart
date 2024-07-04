import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/src/providers/get_settings_provider.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/src/url_launcher_uri.dart';

class EyadDownloadPage extends ConsumerWidget {
  const EyadDownloadPage({super.key});
  static String get routeName => "download";
  static String get routePath => "/$routeName";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorProvider = ref.read(appColorLightProvider);
    
    return Scaffold(
    appBar: AppBar(backgroundColor: colorProvider.whiteish,),
      body: Center(
        child: Container(
            constraints: !kIsWeb ? null : const BoxConstraints(maxWidth: 400),
           
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorProvider.redish,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Assets.png.logoWhite.image(fit: BoxFit.fill),
                  ),
                  title: Text(
                    "إياد",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 28),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              _buildText("4.4"),
                              const Icon(
                                Icons.star,
                                size: 12,
                              ),
                            ],
                          ),
                          _buildText("1ألف مراجعة")
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                      Column(
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.download,
                                size: 12,
                              ),
                            ],
                          ),
                          _buildText("30ميغابايت")
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                      Column(
                        children: [
                          _buildText("+1000"),
                          _buildText("عملية تنزيل")
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.verified,
                            size: 12,
                          ),
                          _buildText("تطبيق أمن")
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                DynamicButton(
                  radius: 16,
                  title: "تحميل ",
                  onPressed: () async {
                    BotToast.showLoading();
                    try {
                        final setting = await ref.read(getSettingFuture.future);
                    
                    final url=setting?.apkUrl;
                    if (url == null || url.isEmpty) {
                      BotToast.showText(
                        duration: const Duration(seconds: 5),
                         text:
                              "لم يتم العثور على رابط التحميل يرجى المحاولة لاحقاََ");
                    }else{
                    await  launchUrl(Uri.parse(url));
                    }
                    } catch (e) {
                      BotToast.showText(
                        duration: const Duration(seconds: 5),
                          text:
                              "لم يتم العثور على رابط التحميل يرجى المحاولة لاحقاََ");
                    }
                  
                                          BotToast.closeAllLoading();
                        
                  },
                ),
                // DynamicButton(
                //   type: ButtonTypes.Natural,
                //   radius: 16,
                //   title: "مشاركة",
                //   onPressed: () async {},
                // ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Assets.screen.values.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Assets.screen.values[index].image()),
                      );
                    },
                  ),
                ),
                 const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Builder _buildText(String text) => Builder(builder: (context) {
        return Text(
          text,
          style: Theme.of(context).textTheme.labelSmall,
        );
      });
}
