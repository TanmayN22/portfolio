import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/modules/home/controllers/image_controller.dart';

class ImageBox extends StatelessWidget {
  const ImageBox({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.find();

    return GestureDetector(
      onTap: imageController.changeImage,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Obx(
            () => Image.asset(
              imageController.imageList[imageController
                  .currentImageIndex
                  .value],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
