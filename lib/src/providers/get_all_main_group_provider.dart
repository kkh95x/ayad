import 'package:ayad/src/models/group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const fakeGroups = <Group>[
  Group(name: "الشاشات", name2: "", isHiden: false),
  Group(name: "الجامات", name2: "", isHiden: false),
  Group(name: "البطاريات", name2: "", isHiden: false),
  Group(name: "أكسسوارات الجامات", name2: "", isHiden: false),
  Group(name: "البفلات", name2: "", isHiden: false),
  Group(name: "الشاسيات", name2: "", isHiden: false),
  Group(name: "أغطية", name2: "", isHiden: false),
  Group(name: "فريمات", name2: "", isHiden: false),
  Group(name: "البصمات", name2: "", isHiden: false),
  Group(name: "بلورات الكميرات", name2: "", isHiden: false),
  Group(name: "بيوت السيم", name2: "", isHiden: false),
  Group(name: "تتشات", name2: "", isHiden: false),
  Group(name: "أقلام", name2: "", isHiden: false),
  Group(name: "البوردات", name2: "", isHiden: false),
  Group(name: "ايسيات الشحن", name2: "", isHiden: false),
  Group(name: "أكسسوارات الصيانة", name2: "", isHiden: false),
  Group(name: "أزرار البور", name2: "", isHiden: false),
  Group(name: "حساسات", name2: "", isHiden: false),
  Group(name: "جكات الشحن", name2: "", isHiden: false),
  Group(name: "فلاتات الشحن", name2: "", isHiden: false),
  Group(name: "فلاتات الوصل", name2: "", isHiden: false),
  Group(name: "السماعات", name2: "", isHiden: false),
  Group(name: "الكميرات", name2: "", isHiden: false),
  Group(name: "كونكترات بوردات", name2: "", isHiden: false),
  Group(name: "فلاتات الرجوع", name2: "", isHiden: false),
  Group(name: "كبس فلاتات الشاشات", name2: "", isHiden: false),
  Group(name: "التواصي للقطع الغير موجودة", name2: "", isHiden: false),
];
final getAllGroupProvider = FutureProvider<List<Group>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return fakeGroups;
});
