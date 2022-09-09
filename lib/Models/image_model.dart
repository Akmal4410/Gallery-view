import 'package:hive_flutter/hive_flutter.dart';
part 'image_model.g.dart';

@HiveType(typeId: 0)
class ImageModel extends HiveObject {
  @HiveField(0)
  String imagePath;

  ImageModel({required this.imagePath});
}
