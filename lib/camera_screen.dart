import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_image_view/Models/image_model.dart';
import 'package:gallery_image_view/gallery_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String? imagePath;
  Box<ImageModel>? imageBox;

  @override
  void initState() {
    imageBox = Hive.box<ImageModel>('images');
    super.initState();
  }

  Future<void> pickImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    setState(() {
      imagePath = image.path;
    });
  }

  Future<void> addImageDataBase() async {
    if (imagePath == null) {
      print('some error occurs');
      return;
    }
    final _image = ImageModel(imagePath: imagePath!);
    await imageBox!.add(_image);
    print("image added sucessfully to the database");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE38B29),
        title: const Text('Gallery View'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => GalleryScreen()));
            },
            icon: const Icon(Icons.wallpaper),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 30),
            CircleAvatar(
              radius: 60,
              backgroundImage: (imagePath == null)
                  ? const AssetImage('assets/images/avatar.jpeg')
                  : FileImage(File(imagePath!)) as ImageProvider,
              backgroundColor: Color(0xFFFFD8A9),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE38B29),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: const StadiumBorder()),
              child: const Text(
                'Camera',
                style: TextStyle(fontSize: 17),
              ),
              onPressed: () {
                pickImageCamera();
                print('Successsfully Addded');
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE38B29),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: const StadiumBorder()),
              child: const Text(
                'Save to Gallery',
                style: TextStyle(fontSize: 17),
              ),
              onPressed: () {
                addImageDataBase();
              },
            ),
          ],
        ),
      ),
    );
  }
}
