import 'package:ayad/src/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final productformProvider = Provider.family<FormGroup, Product?>((ref, product) {
  return FormGroup({

    "groupName": FormControl<String>(
        value: product?.groupName, validators: [Validators.required]),
    "nameArabic": FormControl<String>(
        value: product?.nameArabic, validators: [Validators.required]),
    "description": FormControl<String>(value: product?.description),
    "isHiden": FormControl<bool>(
        value: product?.isHiden, validators: [Validators.required]),
    "productCode": FormControl<String>(value: product?.productCode),
    "price": FormControl<double>(value: product?.price),
    "count": FormControl<double>(value: product?.count),
    "imageUrl": FormControl<String>(value: product?.imageUrl),
    "type": FormControl<String>(value: product?.type),
    "makfol":FormControl<bool>(value: product?.makfol)
  });
});
