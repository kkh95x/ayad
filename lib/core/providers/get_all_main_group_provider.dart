

import 'package:ayad/core/models/group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
const fakeGroups=<Group>[
  Group(name: "الشاشات"),
   Group(name: "الجامات"),
    Group(name: "البطاريات"),
        Group(name: "أكسسوارات الجامات"),
        Group(name: "البفلات"),
        Group(name: "الشاسيات"),
        Group(name: "أغطية"),
        Group(name: "فريمات"),
        Group(name: "البصمات"),
        Group(name: "بلورات الكميرات"),
        Group(name: "بيوت السيم"),
        Group(name: "تتشات"),
        Group(name: "أقلام"),
        Group(name: "البوردات"),
        Group(name: "ايسيات الشحن"),
        Group(name: "أكسسوارات الصيانة"),
        Group(name: "أزرار البور"),
        Group(name: "حساسات"),
        Group(name: "جكات الشحن"),
        Group(name: "فلاتات الشحن"),
        Group(name: "فلاتات الوصل"),
        Group(name: "السماعات"),
        Group(name: "الكميرات"),
        Group(name: "كونكترات بوردات"),
        Group(name: "فلاتات الرجوع"),
        Group(name: "كبس فلاتات الشاشات"),
        Group(name: "التواصي للقطع الغير موجودة"),
        

];
final getAllGroupProvider=FutureProvider<List<Group>>((ref)async {

  await Future.delayed(const Duration(seconds: 1));
  return fakeGroups;
});