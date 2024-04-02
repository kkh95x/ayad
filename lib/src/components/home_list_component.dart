import 'package:ayad/src/components/admin_home_list_component.dart';
import 'package:ayad/src/components/coustomer_home_list.dart';
import 'package:ayad/src/components/vistor_home_list_component.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeListComponent extends ConsumerWidget {
  const HomeListComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userType = ref.watch(authNotifierProvider).value?.currentUser?.type;
    if (userType == UserType.admin) {
      return const AdminHomeListComponent();
    } else if (userType == UserType.customer) {
      return const CoustomerHomeListComponent();
    } else {
      return const VistorHomeListComponent();
    }
  }
}
