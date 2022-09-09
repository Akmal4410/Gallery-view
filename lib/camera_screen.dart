import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_image_view/Models/image_model.dart';
import 'package:gallery_image_view/gallery_screen.dart';
import 'package:gallery_saver/gallery_saver.dart';
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
    await GallerySaver.saveImage(image.path);
    setState(() {
      imagePath = image.path;
    });
  }

  Future<void> addImageDataBase(BuildContext context) async {
    if (imagePath == null) {
      print('some error occurs');
      return;
    }
    final _image = ImageModel(imagePath: imagePath!);
    await imageBox!.add(_image);
    print("image added sucessfully to the database");
    addedAlertBox(context);
    setState(() {
      imagePath = null;
    });
  }

  void addedAlertBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: const Color(0xFFFDEEDC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Column(
              children: const [
                Text('Alert'),
                Divider(
                  color: Color(0xFFE38B29),
                ),
              ],
            ),
            content: const Text('Image added successfully to the database'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (ctx) => GalleryScreen()));
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    color: Color(0xFFE38B29),
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDEEDC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE38B29),
        title: const Text('Gallery View'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const GalleryScreen()));
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
              backgroundColor: const Color(0xFFFFD8A9),
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
                addImageDataBase(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
