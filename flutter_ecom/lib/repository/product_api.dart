import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/common/common.dart';
import 'package:flutter_ecom/provider/imageurl_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// File? selectedImage;

class ProductApi {
  Future<void> picImageFromGallery(BuildContext context) async {
    final imageProvider = Provider.of<ImageUrlProvider>(context, listen: false);

    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    imageProvider.setImage(File(pickedImage.path));

    await uploadImage(imageProvider);
  }

  Future<void> uploadImage(ImageUrlProvider imageProvider) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/products/upload-image'),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
          'image', imageProvider.selectedImage.path),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        'Image upload failed (${response.statusCode}): ${response.body}',
      );
    }

    final result = jsonDecode(response.body) as Map<String, dynamic>;
    final imageUrl = result['url'];
    if (imageUrl is! String || imageUrl.isEmpty) {
      throw const FormatException(
          'Image upload response did not contain a URL.');
    }

    imageProvider.setUrl(imageUrl);
  }
}
