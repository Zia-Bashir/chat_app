import 'package:chat_app/src/common/entities/entities.dart';
import 'package:chat_app/src/common/firebase/firebase_reference.dart';
import 'package:chat_app/src/common/routes/names.dart';
import 'package:chat_app/src/common/services/services.dart';
import 'package:chat_app/src/common/store/store.dart';
import 'package:chat_app/src/common/values/values.dart';
import 'package:chat_app/src/common/widgets/toast.dart';
import 'package:chat_app/src/pages/signin/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  final state = SignInState();
  SignInController();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'openid',
      // 'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> handleGoogleSignIn() async {
    try {
      var user = await _googleSignIn.signIn();
      if (user != null) {
        //* ---- Get User Google Authentication
        final googleAuth = await user.authentication;
        //* ---- Get User Credentials of Google
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        //* ---- SignIn with Credentials
        await auth.signInWithCredential(credential);

        //= ---- Storing User Data
        String displayName = user.displayName ?? user.email;
        String id = user.id;
        String email = user.email;
        String photoUrl = user.photoUrl ?? '';
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.displayName = displayName;
        userProfile.accessToken = id;
        userProfile.email = email;
        userProfile.photoUrl = photoUrl;

        //* --- Store UserProfile in Local Storage ----
        UserStore.to.saveProfile(userProfile);

        //* --- Check if user firebase is exist or not ----
        var userBase = await userRF
            .withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData userData, options) =>
                    userData.toFirestore())
            .where("id", isEqualTo: id)
            .get();

        //* --- If not exist ----
        if (userBase.docs.isEmpty) {
          final data = UserData(
              id: id,
              name: displayName,
              email: email,
              photourl: photoUrl,
              location: '',
              fcmtoken: '',
              addtime: Timestamp.now());

          //* --- Add data in collection ----
          await userRF
              .withConverter(
                  fromFirestore: UserData.fromFirestore,
                  toFirestore: (UserData userData, options) =>
                      userData.toFirestore())
              .add(data);
        }
        toastInfo(msg: "Login Success");
        await StorageServices.to.setBool(LOGIN_STATE, true);
        Get.offAllNamed(AppRoutes.APPLICATION);
      }
    } catch (e) {
      toastInfo(msg: "Error", backgroundColor: Colors.red);
    }
  }

  //* ------------------ SignOut ------------------

  signOut() async {
    try {
      await _googleSignIn.signOut();
      toastInfo(msg: "Logout Success");
      await StorageServices.to.setBool(LOGIN_STATE, false);
      Get.offAllNamed(AppRoutes.SIGNIN);
    } catch (e) {
      toastInfo(msg: "Error", backgroundColor: Colors.red);
    }
  }
}
