import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerUtils {
  // singleton instance
  static final ImagePickerUtils _instance = ImagePickerUtils._internal();

  factory ImagePickerUtils() => _instance;

  ImagePickerUtils._internal();

  // Method to pick an image from the gallery
  Future<File?> pickImageFromGallery() async {
    ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        return File(value.path);
      }
      return null;
    });
  }

  // Method to capture an image using the camera
  Future<File?> pickImageFromCamera() async {
    return null; // Return null if no image was captured
  }

  Future<String?> captureScreenshot(
      {required GlobalKey<State<StatefulWidget>> key}) async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;

      if (boundary.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 20));
        return captureScreenshot(key: key);
      }

      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Get the temporary directory
      final tempDir = await getTemporaryDirectory();

      // Create a unique filename using the current timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final tempFile = File('${tempDir.path}/screenshot_$timestamp.png');
      await tempFile.writeAsBytes(pngBytes);
      return tempFile.path;
    } catch (e) {
      print("Screenshot failed: $e");
    }
    throw Exception("Failed to capture screenshot");
  }
}
