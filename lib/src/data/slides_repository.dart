import 'package:ayad/src/models/slides.dart';

abstract class SlidesRepository {
  Future<void>create(Slide slide);
  Future<void> update(Slide slide);
  Future<void> delete(String slideId);
  Future<List<Slide>> get({SlidesType? slidesType});
  
}