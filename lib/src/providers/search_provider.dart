import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider=FutureProvider.autoDispose.family<List<String>,String>((ref, arg) async{
  await Future.delayed(const Duration(seconds: 1));
  return [
    for(int i=0;i<10;i++)
    "منتج $i"
  ];
},);