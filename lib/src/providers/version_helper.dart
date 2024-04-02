
import 'package:ayad/src/providers/get_settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
final getCurrentVersion=FutureProvider<String>((ref)async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      return version;
});
final versionCheckerProvider =
    StateNotifierProvider<VersionNotifer,VersionStutes>((ref) => VersionNotifer(ref)..init());

enum VersionStutes { allowed, rejected }

class VersionNotifer extends StateNotifier<VersionStutes> {
  VersionNotifer(this.ref) : super(VersionStutes.allowed);
  Ref ref;
  init() async {
    // final user = ref.watch(authNotifierProvider).value?.currentUser;
    // if (user != null) {
      String version =await ref.read(getCurrentVersion.future);
      final setting = await ref.read(getSettingAdminFuture.future);
      if (setting != null) {
     
          final versionAllowed = setting.minVersion;
          if (isVersionLessThan(version,versionAllowed)) {
           
            state = VersionStutes.rejected;
          } else {
             if(mounted){
            state = VersionStutes.allowed;}
          }
        
        
      }
    }
  // }
}
bool isVersionLessThan(String currentVersion, String targetVersion) {
  List<int> currentVersionNumbers = currentVersion.split('.').map(int.parse).toList();
  List<int> targetVersionNumbers = targetVersion.split('.').map(int.parse).toList();

  for (int i = 0; i < currentVersionNumbers.length; i++) {
    //if equle check the next number
    if (currentVersionNumbers[i] < targetVersionNumbers[i]) {
      return true; 
    } else if (currentVersionNumbers[i] > targetVersionNumbers[i]) {
      return false; 
    }
  }

  return false;
}
