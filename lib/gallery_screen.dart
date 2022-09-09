import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_image_view/Models/image_model.dart';
import 'package:gallery_image_view/Models/single_image_screen.dart';
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

  void deletedAlertBox(int key) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Column(
              children: [
                Text('Alert'),
                Divider(),
              ],
            ),
            content: Text('Do you want to confirm the deletion'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await imageBox!.delete(key);
                  Navigator.pop(ctx);
                },
                child: Text('Ok'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDEEDC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE38B29),
        title: Text('Gallery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ValueListenableBuilder(
          valueListenable: imageBox!.listenable(),
          builder:
              (BuildContext context, Box<ImageModel> images, Widget? child) {
            return GridView.builder(
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                final key = images.keys.toList()[index];
                final _image = images.get(key);
                return GestureDetector(
                  onLongPress: () {
                    deletedAlertBox(key);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => SingleImageScreen(
                          imageModel: _image,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      fit: BoxFit.cover,
                      image: FileImage(
                        File(_image!.imagePath),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
