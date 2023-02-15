import 'package:chat_app/src/pages/messages/photoview/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../common/utils/utils_index.dart';

class PhotoViewScreen extends GetView<PhotoController> {
  const PhotoViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.mainColor,
                AppColors.skyColor,
                AppColors.greenColor,
                //AppColors.yellowColor,
              ],
              transform: GradientRotation(90),
            ),
          ),
          child: SafeArea(
            child: Text(
              "Image View",
              style: style.subtitle1?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: PhotoView(
          imageProvider: NetworkImage(controller.state.phoroUrl.value),
        ),
      ),
    );
  }
}
