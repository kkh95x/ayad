import 'package:ayad/core/models/group.dart';
import 'package:ayad/core/providers/get_all_main_group_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const fakeSubGroup = <Group>[
  Group(name: "سامسونع"),
  Group(name: "شاومي"),
  Group(name: "هواوي"),
  Group(name: "أيفون"),
  Group(name: "أنفنكس"),
  Group(name: "أيتيل"),
  Group(name: "TCL"),
  Group(name: "تكنو"),
  Group(name: "ريلمي"),
  Group(name: "لينفو"),
  Group(name: "أوبو"),
];
const fakeSub2Group = <Group>[
  Group(name: "فئة A"),
  Group(name: "فئة J"),
  Group(name: "فئة G"),
  Group(name: "فئة M"),
  Group(name: "فئة S"),
  Group(name: "فئة NOTE"),
  Group(name: "فئة C"),
  Group(name: "فئة E"),
  Group(name: "فئة F"),
  Group(name: "فئة TAB"),
];
final fakeSub3Group = const <Group>[
      Group(name: "A01"),
      Group(name: "A01 Core"),
      Group(name: "A02"),
      Group(name: "A02s"),
      Group(name: "A03"),
      Group(name: "A03core"),
      Group(name: "A03s"),
      Group(name: "A04"),
      Group(name: "A04e"),
      Group(name: "A04s"),
      Group(name: "A05"),
      Group(name: "A05"),
      Group(name: "A05s"),
      Group(name: "A10"),
      Group(name: "A10s"),
      Group(name: "A11"),
      Group(name: "A12s"),
      Group(name: "A127"),
      Group(name: "A13"),
      Group(name: "A14"),
    ] +
    [
      for (int i = 20; i < 40; i++) ...[
        Group(name: "A${i}s"),
        Group(name: "A${i}e"),
      ]
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
