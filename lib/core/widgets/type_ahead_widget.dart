import 'package:ayad/core/providers/search_provider.dart';
import 'package:ayad/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TextSearchWidget extends ConsumerWidget {
  const TextSearchWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: TypeAheadField<String>(
        
        suggestionsCallback: (search) => ref.read(searchProvider(search).future),
        builder: (context, controller, focusNode) {
      return TextField(
        
        controller: controller,
        focusNode: focusNode,
        autofocus: false,
         
        decoration: InputDecoration(
         fillColor: ref.read(appColorLightProvider).whiteish,  
         filled: true,
         
        label: Text("البحث",style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: ref.read(appColorLightProvider).greyish. shade400
        ),),
        
         prefixIcon: Icon(Icons.search,color:  ref.read(appColorLightProvider).greyish. shade400,),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ref.read(appColorLightProvider).greyish. shade400 ),
            borderRadius: BorderRadius.circular(16.r,)
          
          ),
            
        )
      );
        },
        loadingBuilder: (context) {
          return Container(
            height: 100.h,
            padding: EdgeInsets.all(20.r),
            color: ref.read(appColorLightProvider).whiteish,
          child:const Center(child: CircularProgressIndicator(),),
          );
        },
        listBuilder: (context, children) {
          return SingleChildScrollView(
            child: Material(
              elevation: 6,
              child: Container(
                color: ref.read(appColorLightProvider).whiteish,
                child: Column(
                  children: children.map((e) => Padding(padding: EdgeInsets.symmetric(vertical: 2.h),child: e,)).toList(),
                ),
              ),
            ),
          );
        },
        itemBuilder: (context, name) {
      return ListTile(
        leading:const Icon(Icons.search),
        title: Text(name),
        trailing:const Text("12\$"),
      );
        },
        onSelected: (city) {
         
        },
      ),
    );
  }
}