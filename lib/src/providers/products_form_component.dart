import 'package:ayad/src/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final productformProvider = Provider.family<FormGroup, Product?>((ref, product) {
  return FormGroup({

    "productName": FormControl<String>(
        value: product?.productName, validators: [Validators.required]),
    "productFullName": FormControl<String>(
        value: product?.productFullName, validators: [Validators.required]),
    "productsSearching1": FormControl<String>(
        value: product?.productsSearching1,),
     "productsSearching2": FormControl<String>(
        value: product?.productsSearching2,),
         "productsSearching3": FormControl<String>(
        value: product?.productsSearching3,),
       "productsSearching4": FormControl<String>(
        value: product?.productsSearching4,),

   
    "description": FormControl<String>(value: product?.description),
    "isHiden": FormControl<bool>(
        value: product?.isHiden,),
    "price": FormControl<double>(value: product?.price),
    "count": FormControl<double>(value: product?.count),
    "imageUrl": FormControl<String>(value: product?.imageUrl),
    "type": FormControl<String>(value: product?.type),
    "makfol":FormControl<bool>(value: product?.makfol)
  });
});
