import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_image_view/Models/image_model.dart';

class SingleImageScreen extends StatelessWidget {
  const SingleImageScreen({
    super.key,
    required this.imageModel,
  });
  final ImageModel imageModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDEEDC),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Image'),
        backgroundColor: const Color(0xFFE38B29),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: FileImage(
                File(imageModel.imagePath),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
