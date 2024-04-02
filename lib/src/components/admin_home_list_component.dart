import 'package:ayad/src/components/coustomer_home_list.dart';
import 'package:ayad/src/components/vistor_home_list_component.dart';
import 'package:ayad/src/widgets/tab_bar_widget.dart';
import 'package:flutter/material.dart';

class AdminHomeListComponent extends StatelessWidget {
  const AdminHomeListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarWidget(
      tabs: [Text("قسم الزوار",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),), Text("قسم الزبائن",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)],
      children: [VistorHomeListComponent(), CoustomerHomeListComponent()],
    );
  }
}
