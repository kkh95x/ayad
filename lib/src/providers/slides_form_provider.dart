import 'package:ayad/src/models/slides.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final slidesFormProvider = Provider.family<FormGroup, Slide?>((ref, slide) {
  return FormGroup({
    "imageUrl": FormControl<String>(
        value: slide?.imageUrl, validators: [Validators.required]),
    "title": FormControl<String>(
        value: slide?.title, validators: [Validators.required]),
    "slidesType": FormControl<SlidesType>(value: slide?.slidesType),
    "left": FormControl<String>(value: slide?.left),
    "right": FormControl<String>(value: slide?.right),
    "isHiden": FormControl<bool>(value: slide?.isHiden),
  });
});
