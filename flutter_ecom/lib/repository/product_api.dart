import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/provider/imageurl_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// File? selectedImage;

class ProductApi {
  Future picImageFromGallery(BuildContext context) async {
    final myImage = Provider.of<ImageUrlProvider>(context);

    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    // selectedImage = File(pickedImage.path);
    myImage.setImage(File(pickedImage.path));

    await uploadImage(context);
  }

  Future uploadImage(context) async {
    final myurl = Provider.of<ImageUrlProvider>(context);
    final myImage = Provider.of<ImageUrlProvider>(context);

    final Reference postImageRef =
        FirebaseStorage.instance.ref().child("Post Images");
    var timeKey = DateTime.now();

    final UploadTask uploadTask =
        postImageRef.child("$timeKey.jpg").putFile(myImage.selectedImage);

    var imageUrl =
        await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    myurl.setUrl(imageUrl.toString());

    // url = imageUrl.toString();
  }
}
