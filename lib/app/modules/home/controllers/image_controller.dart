import 'package:get/get.dart';

class ImageController extends GetxController {
  final List<String> imageList = [
    'assets/images/tanmay.jpeg',
    'assets/images/tanmay_code.jpg',
    'assets/images/tanmay_1.jpeg',
  ];

  var currentImageIndex = 0.obs;

  void changeImage() {
    currentImageIndex.value =
        (currentImageIndex.value + 1) % imageList.length;
  }
}
