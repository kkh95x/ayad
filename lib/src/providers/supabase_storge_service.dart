import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supbaseStorgeServicesProvider= Provider((ref) => SupaStorgeService(Supabase.instance.client));
class SupaStorgeService {
  SupabaseClient supa;
  SupaStorgeService(this.supa);

  Future<String?> saveGroupsFile(File file, String filePath) async {
    try {
    await supa.storage.from("groups").upload(filePath, file);
      
    final url= supa.storage.from("groups").getPublicUrl(filePath);
    return url;
    } catch (e) {
      debugPrint("---------> ${e.toString()}");
      return null;
    }
  
  }
}