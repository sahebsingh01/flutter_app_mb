import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:muski_bday/ui/uploadform/model/wish_model.dart';
import 'package:muski_bday/utils/constants.dart';
import 'package:muski_bday/utils/preference_utils.dart';

class FirebaseManager {
  static Future addBirthdayWish(WishModel wish) async {
    final databaseReference = Firestore.instance;
    databaseReference.settings(persistenceEnabled: false);
    databaseReference
        .collection("Wishes")
        .document(wish.name)
        .setData(wish.toJson());
  }

  static Future<void> uploadImage(
      File image, bool isProfilePic, String path) async {
    var reference = FirebaseStorage.instance
        .ref()
        .child(path + (isProfilePic ? "/profilePic" : "/picture"));
    var uploadTask = reference.putFile(image);
    var downloadUrl = (await uploadTask.onComplete);
    String url = (await downloadUrl.ref.getDownloadURL());
    isProfilePic
        ? setString(PreferencesConst.profilePic, url)
        : setString(PreferencesConst.pictureUrl, url);
  }

  static Future<void> uploadSignature(Uint8List image, String path) async {
    var reference = FirebaseStorage.instance.ref().child(path + "/signature");
    var uploadTask = reference.putData(image);
    var downloadUrl = (await uploadTask.onComplete);
    String url = (await downloadUrl.ref.getDownloadURL());
    setString(PreferencesConst.signature, url);
  }

  static Stream<QuerySnapshot>  getWishes() {
    final databaseReference = Firestore.instance;
    databaseReference.settings(persistenceEnabled: false);
    return databaseReference.collection("Wishes").snapshots();
  }
}
