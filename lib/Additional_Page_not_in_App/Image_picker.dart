import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class imagepicker extends StatefulWidget {
  const imagepicker({super.key});

  @override
  State<imagepicker> createState() => _imagepickerState();
}

class _imagepickerState extends State<imagepicker> {
  @override
  File? file;
  GetImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    file = File(photo!.path);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await GetImage();
              },
              child: Text('Pick Image'),
            ),
          ),
          if (file != null) Image.file(file!),
        ],
      ),
    );
  }
}
