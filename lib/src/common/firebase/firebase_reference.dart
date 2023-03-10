import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
final storage = FirebaseStorage.instance;

final userRF = firestore.collection("UserData");
final messageRF = firestore.collection("messages");
final chatImageRF = storage.ref("chat");
