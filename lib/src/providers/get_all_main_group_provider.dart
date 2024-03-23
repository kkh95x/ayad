import 'package:ayad/src/models/group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const fakeGroups = <Group>[
  Group(isMainGroup: true,   name: "الشاشات", name2: "", isHiden: false,imageUrl: "https://www.lifehacker.com.au/wp-content/uploads/sites/4/2021/10/12/6172902dbcbd25c7595d8d61184a28cb-scaled.jpg"),
  Group(isMainGroup: true,   name: "الجامات", name2: "", isHiden: false,imageUrl: "https://www.lifehacker.com.au/wp-content/uploads/sites/4/2021/10/12/6172902dbcbd25c7595d8d61184a28cb-scaled.jpg"),
  Group(isMainGroup: true,   name: "البطاريات", name2: "", isHiden: false,imageUrl: "https://4.imimg.com/data4/MP/AT/ANDROID-57535866/product-500x500.jpeg"),
  Group(isMainGroup: true,   name: "أكسسوارات الجامات", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "البفلات", name2: "", isHiden: false,imageUrl: "https://shop.baltrade.eu/img/product/allegro/Przenosny_glosnik_Bluetooth_5_0_z_odtwarzaczem_MP3_Defender_Boomer_20-9.jpg"),
  Group(isMainGroup: true,   name: "الشاسيات", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "أغطية", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "فريمات", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "البصمات", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "بلورات الكميرات", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "بيوت السيم", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "تتشات", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "أقلام", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "البوردات", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "ايسيات الشحن", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "أكسسوارات الصيانة", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "أزرار البور", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "حساسات", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "جكات الشحن", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "فلاتات الشحن", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "فلاتات الوصل", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "السماعات", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "الكميرات", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "كونكترات بوردات", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "فلاتات الرجوع", name2: "", isHiden: false),
  Group(isMainGroup: true,   name: "كبس فلاتات الشاشات", name2: "", isHiden: false),
 
];
final getAllGroupProvider = FutureProvider<List<Group>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return fakeGroups;
});
