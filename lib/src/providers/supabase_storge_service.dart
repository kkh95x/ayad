
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supbaseStorgeServicesProvider= Provider((ref) => SupaStorgeService(Supabase.instance.client));
class SupaStorgeService {
  SupabaseClient supa;
  SupaStorgeService(this.supa);

  Future<String?> saveGroupsFile(XFile file, String filePath) async {
    try {
    await supa.storage.from("groups").uploadBinary(filePath,await file.readAsBytes());
      
    final url= supa.storage.from("groups").getPublicUrl(filePath);
    return url;
    } catch (e) {
      debugPrint("---------> ${e.toString()}");
      return null;
    }
  
  }
}