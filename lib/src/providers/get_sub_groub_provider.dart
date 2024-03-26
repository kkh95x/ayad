import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/providers/get_all_main_group_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const fakeSubGroup = <Group>[
  // Group(name: "سامسونع", name2: "samsong",isHiden: false,hexColor: "#152270"),
  // Group(name: "شاومي", name2: "xiami",isHiden: false,hexColor: "#f5821f"),
  // Group(name: "هواوي", name2: "hawai",isHiden: false),
  // Group(name: "أيفون", name2: "iphone",isHiden: false,hexColor: "#0E2087"),
  // Group(name: "أنفنكس", name2: "infinix",isHiden: false,hexColor: "#73F440"),
  // Group(name: "أيتيل", name2: "itel",isHiden: false),
  // Group(name: "TCL", name2: "tcl",isHiden: false),
  // Group(name: "تكنو", name2: "tikno",isHiden: false),
  // Group(name: "ريلمي", name2: "relmie",isHiden: false),
  // Group(name: "لينفو", name2: "linvo",isHiden: false),
  // Group(name: "أوبو", name2: "opo",isHiden: false),
];
const fakeSub2Group = <Group>[
  // Group(name: "فئة A", name2: "A",isHiden: false),
  // Group(name: "فئة J", name2: "j",isHiden: false),
  // Group(name: "فئة G", name2: "G",isHiden: false),
  // Group(name: "فئة M", name2: "m",isHiden: false),
  // Group(name: "فئة S", name2: "s",isHiden: false),
  // Group(name: "فئة NOTE", name2: "note",isHiden: false),
  // Group(name: "فئة C", name2: "c",isHiden: false),
  // Group(name: "فئة E", name2: "e",isHiden: false),
  // Group(name: "فئة F", name2: "f",isHiden: false),
  // Group(name: "فئة TAB", name2: "tab",isHiden: false),
];
final fakeSub3Group = const <Group>[
      // Group(
      //   name: "A01",isHiden: false,
      //   name2: "A01",
      // ),
      // Group(name: "A01 src", name2: "A01 src",isHiden: false),
      // Group(name: "A02", name2: "A02",isHiden: false),
      // Group(name: "A02s", name2: "A02s",isHiden: false),
      // Group(name: "A03", name2: "A03",isHiden: false),
      // Group(name: "A03src", name2: "A03src",isHiden: false),
      // Group(name: "A03s", name2: "A03s",isHiden: false),
      // Group(name: "A04", name2: "A04",isHiden: false),
      // Group(name: "A04e", name2: "A04e",isHiden: false),
      // Group(name: "A04s", name2: "A04s",isHiden: false),
      // Group(name: "A05", name2: "A05",isHiden: false),
      // Group(name: "A05", name2: "A05",isHiden: false),
      // Group(name: "A05s", name2: "A05s",isHiden: false),
      // Group(name: "A10", name2: "A10",isHiden: false),
      // Group(name: "A10s", name2: "A10s",isHiden: false),
      // Group(name: "A11", name2: "A11",isHiden: false),
      // Group(name: "A12s", name2: "A12s",isHiden: false),
      // Group(name: "A127", name2: "A127",isHiden: false),
      // Group(name: "A13", name2: "A13",isHiden: false),
      // Group(name: "A14", name2: "A14",isHiden: false),
    ] +
    [
      // for (int i = 20; i < 40; i++) ...[
      //   Group(name: "A${i}s", name2: "A${i}e",isHiden: false),
      //   Group(name: "A${i}e", name2: "A${i}e",isHiden: false),
      // ]
    ];

final getSubGroupProvider =
    FutureProvider.family<List<Group>, Group>((ref, arge) async {
  await Future.delayed(const Duration(seconds: 2));
  if (arge == fakeGroups.first) {
    return fakeSubGroup;
  } else if (arge == fakeSubGroup.first) {
    return fakeSub2Group;
  } else if (arge == fakeSub2Group.first) {
    return fakeSub3Group;
  }
  // else if(arge == fakeSub3Group.first){
  // }
  return [];
});
