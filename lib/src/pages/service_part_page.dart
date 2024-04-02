import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/providers/get_settings_provider.dart';
import 'package:ayad/src/widgets/whats_app_button.dart';
import 'package:ayad/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServicePartPage extends ConsumerWidget {
  const ServicePartPage({super.key});
  static String get routeName => "parts-service";
  static String get routePath => "/$routeName";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return PageTemplate(
        title: "التواصي للقطع الغير موجودة",
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: appColor.whiteish,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          color: appColor.blackish.withOpacity(.4),
                          offset: const Offset(1, 1))
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer(
                        builder: (context, ref, child)  {
                           final setting=ref.watch(getSettingFuture);
                          return 
                          
                           Text(
                           setting.value?.noteForParts?? "-",
                           
                            
                            style: TextStyle(color: appColor.greyish.shade400,height: 1.5),
                          );
                        }
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const WhatsAptButton()
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ));
  }
}
