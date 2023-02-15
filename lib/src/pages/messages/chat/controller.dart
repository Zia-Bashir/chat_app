import 'dart:io';
import 'dart:math';

import 'package:chat_app/src/common/entities/entities.dart';
import 'package:chat_app/src/common/firebase/firebase_reference.dart';
import 'package:chat_app/src/common/utils/utils_index.dart';
import 'package:chat_app/src/common/widgets/toast.dart';
import 'package:chat_app/src/pages/messages/chat/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class ChatController extends GetxController {
  final state = ChatState();
  ChatController();
  File? imagePath;

  @override
  void onInit() {
    //* ---- Getting Parameter ------
    var data = Get.parameters;
    state.docId = data['doc_id']!;
    state.toUid.value = data['to_uid'] ?? '';
    state.toName.value = data['to_name'] ?? '';
    state.toAvatar.value = data['to_avatar'] ?? '';
    super.onInit();
  }

  @override
  void onReady() {
    litenEvent();
    super.onReady();
  }

  @override
  void dispose() {
    state.textController.dispose();
    state.listner.cancle();
    super.dispose();
  }

  //* ---- Send Message ------
  sendMessage() async {
    String sendContent = state.textController.text;

    //* ---- Message Content ------
    var content = Msgcontent(
      content: sendContent,
      type: 'text',
      addtime: Timestamp.now(),
      uid: state.userID,
    );

    //* ---- Add Message to Firestore Collection ------
    await messageRF
        .doc(state.docId)
        .collection("msgList")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg, optoons) => msg.toFirestore())
        .add(content)
        .then((DocumentReference doc) {
      state.textController.clear();
      //Get.focusScope?.unfocus();
    });

    //* ---- Update the Last Message and Time ------
    await messageRF
        .doc(state.docId)
        .update({"last_msg": sendContent, 'last_time': Timestamp.now()});
  }

  //* ------------------ Send Image Message ------------------

  sendImageMessage(url) async {
    var content = Msgcontent(
      content: url,
      type: 'image',
      addtime: Timestamp.now(),
      uid: state.userID,
    );

    //* ---- Add Image Message to Firestore Collection ------
    state.isUploading.value = false;

    await messageRF
        .doc(state.docId)
        .collection("msgList")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg, optoons) => msg.toFirestore())
        .add(content)
        .then((DocumentReference doc) {});

    //* ---- Update the Last Message and Time ------
    await messageRF
        .doc(state.docId)
        .update({"last_msg": "【Image】", 'last_time': Timestamp.now()});
  }

  //* ------------------ Upload Image ------------------

  uploadImage() async {
    if (imagePath == null) return;
    state.isUploading.value = true;

    final fileName = getRandomString(15) + imageFileExtension(imagePath);
    try {
      final ref = chatImageRF.child(fileName);
      ref.putFile(imagePath!).snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.success:
            String imgUrl = await getimgUrl(fileName);
            sendImageMessage(imgUrl);
            break;
          default:
        }
      });
    } catch (e) {
      state.isUploading.value = false;

      toastInfo(msg: "Error");
    }
  }

  //* ------------------ Get Image Message URL ------------------

  Future getimgUrl(String name) async {
    final ref = chatImageRF.child(name);
    var imgUrl = await ref.getDownloadURL();
    return imgUrl;
  }

  //* ---- Listen Message Event ------
  litenEvent() {
    //* ---- Message Display Order --------
    var message = messageRF
        .doc(state.docId)
        .collection("msgList")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg, optoons) => msg.toFirestore())
        .orderBy("addtime", descending: false);
    state.msgContentList.clear();
    state.listner = message.snapshots().listen(
      (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.msgContentList.insert(0, change.doc.data()!);
              }
              break;
            case DocumentChangeType.modified:
              break;
            case DocumentChangeType.removed:
              break;
            default:
          }
        }
      },
      // ignore: avoid_print
      onError: (error) => print("Listen Failed: $error"),
    );
  }

  //! Pending
  screenDialog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 240.h,
                width: 280.w,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 75.h,
                              width: 75.w,
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 10.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: AppColors.greenColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(Icons.image),
                                  Text(
                                    "Gallery",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 75.h,
                              width: 75.w,
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 10.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: AppColors.mainColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(Icons.image),
                                  Text(
                                    "Gallery",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 75.h,
                              width: 75.w,
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 10.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: AppColors.mainColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(Icons.image),
                                  Text(
                                    "Gallery",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 75.h,
                              width: 75.w,
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 10.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: AppColors.greenColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(Icons.image),
                                  Text(
                                    "Gallery",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }

  //* ------------------ Modal Sheet  ------------------

  pickerBottomSheet(context) {
    var style = Theme.of(context).textTheme;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 130.h,
            padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      pickCameraImage();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Text("Camera",
                          style: style.subtitle1?.copyWith(
                              color: AppColors.darkColor,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                const Divider(color: AppColors.darkColor, thickness: 1),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      pickGalleryImage();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Text("Gallery",
                          style: style.subtitle1?.copyWith(
                              color: AppColors.darkColor,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: const Divider(
                    color: Colors.red,
                    thickness: 1,
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Text("Cancel",
                          style: style.subtitle1?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.normal)),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
  //* ------------------ Gallery Image Picker ------------------

  pickGalleryImage() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      XFile? pickedFile =
          await state.picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imagePath = File(pickedFile.path);
        uploadImage();
      }
    } else {
      toastInfo(msg: "No Image Selected");
    }
  }

  //* ------------------ Camera Image Picker ------------------

  pickCameraImage() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      XFile? pickedFile =
          await state.picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        imagePath = File(pickedFile.path);
        uploadImage();
      }
    } else {
      toastInfo(msg: "No Image Selected");
    }
  }

  //* ------------------ Get Random String ------------------

  String getRandomString(int length) {
    final random = Random();
    final codeUnits = List.generate(length, (index) {
      return random.nextInt(26) + 65;
    });
    return String.fromCharCodes(codeUnits);
  }

  //* ------------------ File to String Extension ------------------

  String imageFileExtension(File? imagePath) {
    if (imagePath == null) {
      return '';
    }
    return path.extension(imagePath.path);
  }
}
