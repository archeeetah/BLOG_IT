import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class FirebaseFunction {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> createUserCredential(String name, String email) async{
    try {
      await _firebaseFirestore.collection('users').doc(_auth.currentUser!.uid).set({
        "uid": _auth.currentUser!.uid,
        "name": name,
        "email": email
      }
      );
    }catch(e){
      Get.snackbar("Error", "Please fill all fields",
      snackPosition: SnackPosition.BOTTOM);
    }
  }
}