import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

final userRF = firestore.collection("UserData");
final messageRF = firestore.collection("messages");
