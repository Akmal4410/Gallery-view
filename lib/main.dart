import 'package:flutter/material.dart';
import 'package:gallery_image_view/Models/image_model.dart';
import 'package:gallery_image_view/camera_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ImageModelAdapter());
  }
  await Hive.openBox<ImageModel>('images');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraScreen(),
    );
  }
}
