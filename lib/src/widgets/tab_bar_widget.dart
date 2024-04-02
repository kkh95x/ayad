import 'package:ayad/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class TabBarWidget extends ConsumerWidget {
  const TabBarWidget({
    super.key,
    required this.children,
    required this.tabs,
    this.isSearchable,
    this.showImage,
  });
  final List<Widget> children;
  final List<Widget> tabs;
  final bool? isSearchable;
  final bool? showImage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return DefaultTabController(
      length: children.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: appColor.whiteish),
              child: TabBar(
                padding: EdgeInsets.zero,
                indicator: const BoxDecoration(),
                
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: appColor.redish,
                unselectedLabelColor: appColor.greyish,
            
                tabs: tabs,
                dividerColor: appColor.greyish,
                labelStyle: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
