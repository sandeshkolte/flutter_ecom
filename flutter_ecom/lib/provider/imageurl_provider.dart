import 'dart:io';

import 'package:flutter/material.dart';

class ImageUrlProvider extends ChangeNotifier {
  String _url = "";

  String get url => _url;

  void setUrl(myUrl) {
    _url = myUrl;
    notifyListeners();
  }

  late File _selectedImage;
  File get selectedImage => _selectedImage;

  void setImage(myimage) {
    _selectedImage = myimage;
    notifyListeners();
  }
}
