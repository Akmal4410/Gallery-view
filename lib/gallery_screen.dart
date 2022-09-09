import 'package:flutter/material.dart';
import 'package:gallery_image_view/Models/image_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  Box<ImageModel>? imageBox;

  @override
  void initState() {
    imageBox = Hive.box<ImageModel>('images');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE38B29),
        title: Text('Gallery'),
      ),
      // body: ValueListenableBuilder(
      //   valueListenable: imageBox!.listenable(),
      //   builder: (BuildContext context, Box<ImageModel> images, Widget? child) {
      //     return ListView.separated(
      //       itemBuilder: (context, index) {
      //         // return;
      //       },
      //       separatorBuilder: (context, index) {
      //         return Divider();
      //       },
      //       itemCount: images.length,
      //     );
      //   },
      // ),
    );
  }
}
