import 'package:ayad/src/data/supabase_product_repository.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/models/product.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = FutureProvider.autoDispose.family<List<Product>, (Group?, String)>(
  (ref, arg) async {
    GroupType? groupType;
    final currentUser = ref.watch(authNotifierProvider).value?.currentUser;
    if (currentUser?.type == UserType.admin) {
      groupType = null;
    } else if (currentUser?.type == UserType.customer) {
      groupType = GroupType.customer;
    } else {
      groupType = GroupType.vistor;
    }
    return await ref
        .read(supabaseProductRepositoryProvider)
        .search(arg.$2, groupType,arg.$1);
  },
);
